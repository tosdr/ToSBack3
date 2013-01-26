require 'spec_helper'

describe "Site Controller" do
  describe "site_path#index" do
    let!(:sites) {30.times {FactoryGirl.create(:site)} }
    
    before(:each) do
      visit sites_path
    end
    
    it "contains first site" do
      page.should have_selector('li', Site.first.name)
    end
    
    it "doesn't contain the last site (pagination)" do
      page.should not_have_selector('li', Site.last.name)
    end

    it "lists page numbers" do
      page.should have_selector('div.pagination')
    end
  end
end
