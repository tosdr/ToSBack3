# encoding: UTF-8
namespace :xml do
  desc "Import the XML rules to sites and policies"
  task :import_xml => :environment do
    path = (Rails.env == "development") ? "../../tosdr/tosback2/rules/" : "/root/tosback2/rules/"
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
        Site.create(name:ngxml.xpath("//sitename[1]/@name").to_s)
      end
    
      ngxml.xpath("//sitename/docname").each do |doc|
        # docs << TOSBackDoc.new({site: site, name: doc.at_xpath("./@name").to_s, url: doc.at_xpath("./url/@name").to_s, xpath: doc.at_xpath("./url/@xpath").to_s, reviewed: doc.at_xpath("./url/@reviewed").to_s})
        p = Policy.where(url:doc.at_xpath("./url/@name").to_s, xpath: doc.at_xpath("./url/@xpath").to_s).first
        if p.nil?
          Policy.create do |plcy|
            plcy.name = doc.at_xpath("./@name").to_s
            plcy.url = doc.at_xpath("./url/@name").to_s
            plcy.xpath = (doc.at_xpath("./url/@xpath").to_s == "") ? nil : doc.at_xpath("./url/@xpath").to_s
            plcy.needs_revision = (doc.at_xpath("./url/@reviewed").to_s == "") ? true : nil
            plcy.lang = (doc.at_xpath("./url/@lang").to_s == "") ? nil : doc.at_xpath("./url/@lang").to_s
          end
        end # if p.nil?
      
        unless p.sites.include?(site)
          p.sites << site
        end # unless policy has site already
      end # each doc
    end # each xml file
  
  end
end