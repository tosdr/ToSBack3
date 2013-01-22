require 'spec_helper'

describe Crawl do
  let(:crawl) { FactoryGirl.build(:crawl) }
  
  it { should respond_to(:policy) }
  
  it "has a valid factory" do
    crawl.should be_valid
  end
    
  it "is invalid without a policy_id" do
    crawl.policy_id = nil
    crawl.should_not be_valid
  end
  
  context "when crawl exists already" do
    let!(:current_crawl) { FactoryGirl.create(:crawl) }
    
    it "is invalid with a duplicate policy_id" do
      crawl.should_not be_valid
    end
  end
end
