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
    
    it "links to site_path(:id)" do
      page.should have_link(Site.first.name, href: site_path(Site.first))
    end
  end #index
  
  describe "site_path(:id)" do
    before(:each) do
      visit site_path(site)
    end
    
    context "when site does not have policies" do
      let!(:site) { FactoryGirl.create(:site) }
      
      it "contains the site's title" do
        page.should have_selector("h1", text: site.name )
      end
      
      it "displays message in place of policies"
      
      it "displays a link to add a policy"
      
    end # doesn't have policies
    
    context "when the site has policies" do
      let!(:site) { FactoryGirl.create(:site_with_policies) }
      
      it "lists the site's policies" do
        site.policies.each do |policy|
          page.should have_selector("li", text: policy.name)
        end
      end
      
      it "policy names are links to policy pages" do
        pending("Policy controller and views need to be implemented")
        click_link site.policies.first.name
        page.should have_selector("h1", site.policies.first.name )
      end
      
    end # has policies
  end #show
end
