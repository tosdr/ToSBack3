# encoding: UTF-8
namespace :versions do
  desc "Import reviewed policy versions from tb2 repo"
  task :import_versions => :environment do
    #path will be the path to the tb2 repo passed into the command when running the task
    path = ENV['path']
    
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
        policy = Site.where(name: file[:site].downcase).first.policies.where(name: file[:policy].sub(".txt","")).first
        version = policy.versions.where(created_at: commit[:date].beginning_of_day..commit[:date].end_of_day).first
        
        if version.nil?
          old_policy = IO.popen("cd #{path}; git show #{commit[:sha]}:'#{file[:path]}'").read
          version = policy.versions.new(previous_policy: old_policy)
          version.created_at = commit[:date]
          version.save
        end

      end
    end
          
  end # import_versions
end
  