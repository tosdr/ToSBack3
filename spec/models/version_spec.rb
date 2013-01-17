require 'spec_helper'

describe Version do
  let(:version) { FactoryGirl.build(:version) }
  
  it "has a valid factory" do
    version.should be_valid
  end
  
  it { should respond_to(:policy) }
  
  describe "#validates presence" do
    it "is invalid without a policy_id" do
      version.policy_id = nil
      version.should_not be_valid
    end
    
    it "is invalid without previous data" do
      version.previous_crawl = nil
      version.should_not be_valid
    end
  end
end