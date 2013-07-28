# encoding: UTF-8

desc "Import the XML rules to sites and policies"
task :import_xml => :environment do  
  Dir.foreach(path) do |xml_file| # loop for each xml file/rule
    next if xml_file == "." || xml_file == ".."
    
    filecontent = File.open(path + xml_file)
    ngxml = Nokogiri::XML(filecontent)
    filecontent.close
  
    site = ngxml.xpath("//sitename[1]/@name").to_s
    ngxml.xpath("//sitename/docname").each do |doc|
      # docs << TOSBackDoc.new({site: site, name: doc.at_xpath("./@name").to_s, url: doc.at_xpath("./url/@name").to_s, xpath: doc.at_xpath("./url/@xpath").to_s, reviewed: doc.at_xpath("./url/@reviewed").to_s})
      p = Policy.where(url:doc.at_xpath("./url/@name").to_s, xpath: doc.at_xpath("./url/@name").to_s).first
      unless p
        Policy.create do |p|
          p.name = doc.at_xpath("./@name").to_s
          p.url = doc.at_xpath("./url/@name").to_s
          p.xpath = (doc.at_xpath("./url/@xpath").to_s == "") ? nil : doc.at_xpath("./url/@xpath").to_s
          p.needs_revision = (doc.at_xpath("./url/@reviewed").to_s == "") ? true : nil
          p.lang = doc.at_xpath("./url/@lang").to_s == "") ? nil : doc.at_xpath("./url/@lang").to_s
        end
      end # unless p
      
      #TODO site association here.
    end
  end
  
end