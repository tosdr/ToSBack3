# encoding: UTF-8
namespace :versions do
  desc "Import reviewed policy versions from tb2 repo"
  task :import_versions => :environment do
    #path will be the path to the tb2 repo passed into the command when running the task
    path = ENV['path']
    raise ArgumentError.new "\n\nMust include path like so:\nrails versions:import_versions path=../tosback2/\n\n" if path == nil
    
    io = IO.popen("cd #{path}; git log --format='%H %cd' --after=30/06/2013 --grep='changes for reviewed docs'")
    commit_string = io.read
    io.close
    
    commits = []
    commit_string.each_line do |commit|
      commit_ary = commit.strip.split(/\s/,2)
      commits << {sha: commit_ary[0], date: DateTime.parse(commit_ary[1])}
    end
    
    commits.each do |commit|
      io = IO.popen("cd #{path}; git diff-tree -r --name-only --no-commit-id #{commit[:sha]}")
      files = io.read.split(/\n/)
      io.close
      
      files.map! do |file|
        #each file will be something like "crawl_reviewed/disqus.com/Privacy Policy.txt"
        ary = file.split(/\//)
        {path: file, site: ary[1], policy: ary[2]}
      end

      # site = Site.where(name: file[:site].downcase).first
      files.each do |file|
	file[:policy] = "Terms of Service.txt" if file[:policy] == "Terms Of Service.txt" 
	#fixes issue with some of google's other service's old versions not importing
	#file[:policy] = "Microsoft Services Agreement.txt" if file[:policy] == "Terms of Service.txt" && file[:site].downcase == "msn.com"
        # another cheap fix, but we're just working from one dataset so I'll allow it.
        # ^no longer needed? But I just added this... o_O

        #Some sites have changed companies or names...
        former_site = nil

        #Going to need this for the import debugging:
        #puts file[:site]
        #puts file[:policy]

        #Workarounds for a few inconsistencies...
        if file[:site] == 'comcast.com' || file[:site] == 'comcast.net'
          former_site = file[:site]
          file[:site] = 'xfinity.com'
        elsif file[:site] == 'delicious.com'
          former_site = file[:site]
          file[:site] = 'del.icio.us'
        elsif file[:site] == 'faranow.com'
          former_site = file[:site]
          file[:site] = 'packagetrackr.com'
        elsif file[:site] == 'rapidshare.com'
          next
        end

        policy = Site.where(name: file[:site].downcase).first.policies.where(name: file[:policy].sub(".txt","")).first

        if policy.nil?
          policy = Policy.new(name: file[:policy].sub(".txt",""), obsolete: true)
        end

        version = policy.versions.where(created_at: commit[:date].beginning_of_day..commit[:date].end_of_day).first
        
        if version.nil?
          old_policy = IO.popen("cd #{path}; git show #{commit[:sha]}:'#{file[:path]}'").read
          version = policy.versions.new(text: old_policy)
          version.created_at = commit[:date]
          version.former_site = former_site
          version.diff_url = "https://github.com/tosdr/tosback2/commit/#{commit[:sha]}?diff=split"
          version.save
        end

      end
    end
          
  end # import_versions
end
  
