# encoding: UTF-8
namespace :xml do
  desc "Import the XML rules to sites and policies"
  task :import_xml => :environment do
    path = ENV['path']
    # path = (Rails.env == "development") ? "../../tosdr/tosback2/rules/" : "/root/tosback2/rules/"
    Dir.foreach(path) do |xml_file| # loop for each xml file/rule
      #TODO add path above
      next if xml_file == "." || xml_file == ".."
    
      filecontent = File.open(path + xml_file)
      ngxml = Nokogiri::XML(filecontent)
      filecontent.close
  
      # check to see if site exists
      site = Site.where(name: ngxml.xpath("//sitename[1]/@name").to_s).first
      # create site if it doesn't
      if site.nil?
        site = Site.create(name:ngxml.xpath("//sitename[1]/@name").to_s)
      end
    
      ngxml.xpath("//sitename/docname").each do |doc|
        doc_hash = {}
        doc_hash[:name] = doc.at_xpath("./@name").to_s
        doc_hash[:url] = doc.at_xpath("./url/@name").to_s
        doc_hash[:xpath] = (doc.at_xpath("./url/@xpath").to_s == "") ? nil : doc.at_xpath("./url/@xpath").to_s
        doc_hash[:nr] = (doc.at_xpath("./url/@reviewed").to_s == "") ? true : nil
        doc_hash[:lang] = (doc.at_xpath("./url/@lang").to_s == "") ? nil : doc.at_xpath("./url/@lang").to_s

        p = Policy.where(url:doc_hash[:url], xpath: doc_hash[:xpath]).first
        if p.nil?
          p = Policy.create do |plcy|
            plcy.name = doc_hash[:name] 
            plcy.url = doc_hash[:url]
            plcy.xpath = doc_hash[:xpath]
            plcy.needs_revision = doc_hash[:nr]
            plcy.lang = doc_hash[:lang] 
          end
        end # if p.nil?
      
        unless p.sites.include?(site)
          p.sites << site
        end # unless policy has site already
      end # each doc
    end # each xml file
  end # import_xml

  desc "Export the sites and policies in the db to XML"
  task :export_xml => :environment do
    path = ENV['path']
    
    Site.all.each do |site|
      rule_file = File.open(path + site.name + ".xml","w") # new file or overwrite old file
      rule_file.puts "<sitename name=\"#{site.name}\">\n"

      site.policies.each do |policy|
        rule_file.puts "  <docname name=\"#{policy.name}\">\n"
        rule_file.puts "    <url name=\"#{policy.url}\""
        rule_file.puts " xpath=\"#{policy.xpath}\"" unless policy.xpath.nil?
        rule_file.puts " lang=\"#{policy.lang}\"" unless policy.lang.nil?
        rule_file.puts " reviewed='true'" unless policy.needs_revision
        rule_file.puts ">\n"
        rule_file.puts "      <norecurse name=\"arbitrary\"/>\n    </url>\n  </docname>\n"
      end
      
      rule_file.puts "</sitename>\n"
      rule_file.close
    end #policy.all.each
  end # export_xml
end