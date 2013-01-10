require 'spec_helper'

describe Policy do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:policy).should be_valid
  end
  # it "is invalid without a site_id" do
  #   FactoryGirl.build(:policy, site_id: nil).should_not be_valid
  # end
  
  describe "#validates" do
    describe "attributes can't be blank" do
      it "is invalid without a name" do
        FactoryGirl.build(:policy, name: nil).should_not be_valid
      end 
      it "is invalid without a url" do
        FactoryGirl.build(:policy, url: nil).should_not be_valid
      end
    end
    
    describe "attributes must be unique" do
      let(:uniq) { FactoryGirl.create(:policy) }
      let(:dup) { FactoryGirl.build(:policy) }
    
      context "when url and xpath are duplicates" do
        it "is invalid" do
          dup.should_not be_valid
        end
      end
      
      it "is valid if url is duplicate but xpath is different" do
        dup.xpath = "//div[@id='xxxxx']"
        dup.should be_valid
      end
      it "is valid if xpath is duplicate but url is different" do
        dup.url = "http://ex.com/terms"
        dup.should be_valid
      end
    end # describe unique
  end # validates

end