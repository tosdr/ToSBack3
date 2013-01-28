require 'spec_helper'

describe "Site Controller" do
  describe "site_path#index" do
    before(:all) { 31.times { FactoryGirl.create(:site) } }
    after(:all)  { Site.delete_all }    
    
    before(:each) do
      visit sites_path
    end
    
    it "contains first site" do
      page.should have_selector('li', text: Site.first.name)
    end
    
    it "doesn't contain the 31st site (pagination)" do
      page.should_not have_selector('li', text: Site.last.name)
    end

    it "lists page numbers" do
      page.should have_selector('div.pagination')
    end
  end
end
