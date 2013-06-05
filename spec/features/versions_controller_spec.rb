require 'spec_helper'

describe "VersionsController" do
  
  subject { page }
    
  describe "visiting versions#index" do
    before(:each) { @policy = FactoryGirl.create(:policy_with_sites_and_versions, sites_count: 14, versions_count: 32) }
    before { visit policy_versions_path(@policy) }
    
    it "doesn't contain the 32nd version (pagination)" do
      page.should_not have_selector('li', text: @policy.versions.last.created_at.to_date.to_formatted_s(:long).squish )
      #squish out those extra spaces
    end
    
    #TODO shared example for pagination links
    it "lists page numbers" do
      page.should have_selector('div.pagination')
    end
    
  end
end
