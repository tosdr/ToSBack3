require 'spec_helper'

RSpec.describe "VersionsController" do
  
  subject { page }
    
  describe "visiting versions#index" do
    before(:each) { @policy = FactoryBot.create(:policy_with_sites_and_versions, sites_count: 14, versions_count: 32) }
    before { visit policy_versions_path(@policy) }
    
    it "paginates site links to the first 10" do
      @policy.sites.each_with_index do |site, i|
        if i<10
          expect(page).to have_link(site.name, href: site_path(site.id))
          expect(page).to have_selector('li', text: site.name)
        else
          expect(page).not_to have_link(site.name, href: site_path(site.id))
          expect(page).not_to have_selector('li', text: site.name)
        end
      end
    end

    it "doesn't contain the 32nd version (pagination)" do
      expect(page).not_to have_selector('li', text: @policy.versions.last.created_at.to_date.to_formatted_s(:long).squish )
      #squish out those extra spaces
    end
    
    it { is_expected.to have_link("Back to current policy...", href: policy_path(@policy)) }
    
    #TODO shared example for pagination links
    it "lists page numbers" do
      expect(page).to have_selector('div.pagination')
    end
    
  end
  
  describe "visiting versions#show" do

    context "when policy has many sites and versions" do
      before(:each) { @policy = FactoryBot.create(:policy_with_sites_and_versions, sites_count: 14, versions_count: 32) }
      before { @version = @policy.versions[2] }
      before { visit policy_version_path(@policy,@version) }
      
      it { is_expected.to have_selector('h1', text: @policy.name) }
      it { is_expected.to have_selector('h3', text: @version.created_at.to_date.strftime("%B %-d, %Y")) }
      
      context "clicking a link to a different version" do
        before { click_link(@policy.versions[5].created_at.to_date.strftime("%B %-d, %Y")) }
        
        it { is_expected.to have_selector('h3', text: @policy.versions[5].created_at.to_date.strftime("%B %-d, %Y")) }
      end
    end #many 
         
  end #visiting #show
end
