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
      
      files.each do |file|
        #each file will be something like "crawl_reviewed/disqus.com/Privacy Policy.txt"
        # site = Site.where(name: .downcase).first
      end
    end
          
  end # import_versions
end
  