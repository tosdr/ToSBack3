require 'spec_helper'

RSpec.describe "CrawlController", disabled: true do
  before { @crawl = FactoryBot.create(:crawl) }
  subject { page }

  context "as an admin" do
    before(:each) do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end

    describe "visiting crawl #show" do
      before { visit crawl_path(@crawl) }
      
      xit { has_selector?('h2', text: @crawl.policy.name) }
      xit { has_selector?('div#crawled_policy', text: @crawl.crawled_policy) }
      xit { has_button?('Approve!') }
      xit { has_button?('Skip!') }
      xit { has_button?('Revise...') }
        
    end #visiting crawl #show
  end #as an admin
  
  context "as regular user" do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    
    describe "visiting crawl_path" do
      before { visit crawl_path(@crawl) }
      
      xit "redirects to policy path" do
        current_path.should eq(policy_path(@crawl.policy))
      end
    end #visiting crawl_path
    
  end #as user
end # CrawlController
