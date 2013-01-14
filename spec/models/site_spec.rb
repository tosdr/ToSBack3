require 'spec_helper'

describe Site do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:site).should be_valid
  end
  it "is invalid without a url" do
    FactoryGirl.build(:site, name: nil).should_not be_valid
  end
  
  it { should respond_to(:policies) }  
  it { should respond_to(:commitments) }
    
  describe "#validates uniqueness" do
    let!(:example) { FactoryGirl.create(:site) }
    let(:dup_site) { FactoryGirl.build(:site) }
    
    it "is invalid without a unique url" do
      dup_site.should_not be_valid
    end
    
    it "is invalid if url isn't unique (case insensitive)" do
      dup_site.name.upcase!
      dup_site.should_not be_valid
    end
  end #validates uniqueness
  
  # describe ""
  
end
