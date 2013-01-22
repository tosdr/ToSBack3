require 'spec_helper'

describe Policy do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:policy).should be_valid
  end
  
  it { should respond_to(:sites) }
  it { should respond_to(:commitments) }
  it { should respond_to(:versions) }
  it { should respond_to(:crawl) }
  
  describe "#validates" do
    it "is invalid without a name" do
      FactoryGirl.build(:policy, name: nil).should_not be_valid
    end 
    it "is invalid without a url" do
      FactoryGirl.build(:policy, url: nil).should_not be_valid
    end
  end # validates
  
  context "when policy is created" do
    let!(:uniq) { FactoryGirl.create(:policy) }
    let(:dup) { FactoryGirl.build(:policy) }
  
    it "is invalid if it's a duplicate" do
      dup.should_not be_valid
    end
    it "is valid if url is duplicate but xpath is different" do
      dup.xpath = "//div[@id='xxxxx']"
      dup.should be_valid
    end
    it "is valid if xpath is duplicate but url is different" do
      dup.url = "http://ex.com/terms"
      dup.should be_valid
    end
    
    it "creates an initial version automatically" do
      uniq.versions.count.should eq(1)
    end
  end # when policy is created
end