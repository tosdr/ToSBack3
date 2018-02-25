require 'spec_helper'

RSpec.describe "Site Controller", disabled: true do
  describe "site_path#index" do
    before(:all) do
      32.times { FactoryBot.create(:site_with_policies, policies_count: 1) }
      Site.all[10].policies.first.update_attribute(:needs_revision, true)
    end
    let!(:unreviewed) { Site.all[10] }
    after(:all) do
      Site.delete_all
      Policy.delete_all
      Commitment.delete_all
    end
    
    before(:each) do
      visit sites_path
    end
    
    it "contains first site" do
      page.should have_selector('li', text: Site.first.name)
    end
    
    it "doesn't contain the unreviewed site (scope)" do
      page.should_not have_selector('li', text: unreviewed.name)
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
      let!(:site) { FactoryBot.create(:site) }
      
      it "contains the site's capitalized title" do
        page.should have_selector("h1", text: site.name.capitalize )
      end
      
      it "displays message in place of policies"
      
      it "displays a link to add a policy"
      
    end # doesn't have policies
    
    context "when the site has policies" do
      let!(:site) { FactoryBot.create(:site_with_policies) }
      
      it "lists the site's policies" do
        site.policies.each do |policy|
          page.should have_selector("li", text: policy.name)
        end
      end
      
      xspecify "policy names are links to policy pages" do
        click_link site.policies.first.name
        page.should have_selector("h1", site.policies.first.name )
      end
      
    end # has policies
  end #show
end
