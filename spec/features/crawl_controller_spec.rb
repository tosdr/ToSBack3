require 'spec_helper'

describe "CrawlController" do
  before { @crawl = FactoryGirl.create(:crawl) }
  subject { page }


  describe "visiting crawl #show" do
    before { visit crawl_path(@crawl) }
    
    context "as an admin" do
      it { should have_selector('h2', text: @crawl.created_at) }
    end
    
    context "as regular user" do
      pending "redirects to policy"
    end 
  end #visiting crawl #show
end