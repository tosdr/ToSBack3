require 'spec_helper'

describe Site do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:site).should be_valid
  end
  it "is invalid without a url" do
    FactoryGirl.build(:site, name: nil).should_not be_valid
  end
  describe "duplicate site" do
    before :each do
      @fb = FactoryGirl.create(:site)
    end
    
    it "is invalid without a case insensitive unique url" do
      dup_site = FactoryGirl.build(:site)
      dup_site.name.upcase
      dup_site.should_not be_valid
    end
  end
end
