require 'spec_helper'

describe "PoliciesController" do
  
  subject { page }
  
  describe "visiting #index" do
    before(:all) { 31.times { FactoryGirl.create(:policy) } }
    after(:all)  { Policy.delete_all }

    before(:each) do
      visit policies_path
    end

    it "contains first policy" do
      page.should have_selector('li', text: Policy.first.name)
    end

    it "doesn't contain the 31st policy (pagination)" do
      page.should_not have_selector('li', text: Policy.last.name)
    end

    it "lists page numbers" do
      page.should have_selector('div.pagination')
    end

    it "links to policy_path(:id)" do
      page.should have_link(Policy.first.name, href: policy_path(Policy.first))
    end
  end # policies_path#index
  
  describe "visiting #show" do

    context "when policy has many sites and versions" do
      before do
        @policy = FactoryGirl.create(:policy_with_sites_and_versions, sites_count: 14, versions_count: 17)
        visit policy_path(@policy)
      end
      
      it "paginates site links to the first 10" do
        @policy.sites.each_with_index do |site, i|
          if i<10
            page.should have_link(site.name, href: site_path(site.id))
            page.should have_selector('li', text: site.name)
          else
            page.should_not have_link(site.name, href: site_path(site.id))
            page.should_not have_selector('li', text: site.name)
          end
        end
      end
      
      it { should have_selector('div.pagination') }
      
      it { should have_selector('h1', text: @policy.name) }
      it { should have_selector('h3', text: @policy.updated_at.to_date.strftime("%B %-d, %Y")) }
    end #many 
         
  end #visiting #show
end