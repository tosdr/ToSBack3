# encoding: UTF-8
namespace :xml do
  desc "Import the XML rules to sites and policies"
  task :import_xml => :environment do
    path = ENV['path']
    # Point path to tosback2 folder ( e.g. rake xml:import_xml path=../../tosdr/tosback2/ )
    raise ArgumentError.new "\n\nMust include path like so:\nrails xml:import_xml path=../tosback2/\n\n" if path == nil

    io = IO.popen("cd #{path}; git log --format='%H %s' --after=#{3.days.ago.strftime('%d/%m/%Y')}")
    commit_string = io.read
    io.close

    reviewed_hash = nil
    commit_string.each_line do |commit|
      break if reviewed_hash

      commit_ary = commit.strip.split(/\s/,2)
      reviewed_hash = commit_ary[0] if commit_ary[1] == 'changes for reviewed docs'
    end

    Dir.foreach(path+"rules/") do |xml_file| # loop for each xml file/rule
      next if xml_file == "." || xml_file == ".."
    
      filecontent = File.open(path + "rules/" + xml_file)
      ngxml = Nokogiri::XML(filecontent)
      filecontent.close
  
      # check to see if site exists
      site = Site.where(name: ngxml.xpath("//sitename[1]/@name").to_s.downcase).first
      # create site if it doesn't
      if site.nil?
        site = Site.create(name:ngxml.xpath("//sitename[1]/@name").to_s.downcase)
      end
    
      ngxml.xpath("//sitename/docname").each do |doc|
        doc_hash = {}
        doc_hash[:name] = doc.at_xpath("./@name").to_s
        doc_hash[:url] = doc.at_xpath("./url/@name").to_s
        doc_hash[:xpath] = (doc.at_xpath("./url/@xpath").to_s == "") ? nil : doc.at_xpath("./url/@xpath").to_s
        doc_hash[:nr] = ((doc.at_xpath("./url/@reviewed").to_s == "") || (doc.at_xpath("./url/@reviewed").to_s == "false")) ? true : false
        doc_hash[:lang] = (doc.at_xpath("./url/@lang").to_s == "") ? nil : doc.at_xpath("./url/@lang").to_s
        doc_hash[:txt_file] = (doc_hash[:nr] == false) ? "crawl_reviewed/#{site.name}/#{doc_hash[:name]}.txt" : "crawl/#{site.name}/#{doc_hash[:name]}.txt"

        p = Policy.where(url:doc_hash[:url], name: doc_hash[:name]).first
        if p.nil?
          p = Policy.create do |plcy|
            plcy.name = doc_hash[:name] 
            plcy.url = doc_hash[:url]
            plcy.xpath = doc_hash[:xpath]
            plcy.needs_revision = doc_hash[:nr]
            plcy.lang = doc_hash[:lang] 
            #TODO see if chomp is necessary for making the diffs work right once the
            # new crawler is finished
            File.open(path+doc_hash[:txt_file]) do |crawl|
              plcy.versions.new(text: crawl.read.chomp) do |ver|
                ver.diff_url = "https://github.com/tosdr/tosback2/commit/#{reviewed_hash}?diff=split" unless plcy.needs_revision
              end
            end
          end
        end # if p.nil?
        
        #sets date on version to the correct commit date from git
        unless p.needs_revision == true
          date_of_crawl = IO.popen("cd #{path}; git log -1 --format='%cd' '#{doc_hash[:txt_file]}'").read
          version = p.versions.first
          version.created_at = DateTime.parse(date_of_crawl)
          version.save
          p.created_at = DateTime.parse(date_of_crawl)
          p.save
        end
      
        unless p.sites.include?(site)
          p.sites << site
        end # unless policy has site already
      end # each doc
    end # each xml file
  end # import_xml

  desc "Export the sites and policies in the db to XML"
  task :export_xml => :environment do
    # Point path to tosback2 folder ( e.g. rake xml:export_xml path=../../tosdr/tosback2/ )
    path = ENV['path'] + "rules/"
    raise ArgumentError.new "\n\nMust include path like so:\nrails xml:export_xml path=../tosback2/\n\n" if path == nil
    
    Dir.mkdir(path) unless File.exists?(path)
    
    Site.all.each do |site|
      rule_file = File.open(path + site.name + ".xml","w") # new file or overwrite old file
      rule_file.print "<sitename name=\"#{site.name}\">\n"

      site.policies.each do |policy|
        rule_file.print "  <docname name=\"#{CGI.escape_html(policy.name)}\">\n"
        rule_file.print "    <url name=\"#{CGI.escape_html(policy.url)}\""
        rule_file.print " xpath=\"#{policy.xpath}\"" unless policy.xpath.nil?
        rule_file.print " lang=\"#{policy.lang}\"" unless policy.lang.nil?
        rule_file.print " reviewed=\"true\"" unless policy.needs_revision
        rule_file.print ">\n"
        rule_file.print "      <norecurse name=\"arbitrary\" />\n    </url>\n  </docname>\n"
      end
      
      rule_file.print "</sitename>\n"
      rule_file.close
    end #policy.all.each
  end # export_xml
end
