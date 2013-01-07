require 'spec_helper'

describe Policy do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:policy).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:policy, name: nil).should_not be_valid
  end 
  it "is invalid without a url" do
    FactoryGirl.build(:policy, url: nil).should_not be_valid
  end
  it "is invalid without a site_id" do
    FactoryGirl.build(:policy, site_id: nil).should_not be_valid
  end
  
  pending "is invalid if url and xpath are duplicates"
  pending "is invalid if the site_id and name are duplicates"
  pending "is valid if url is duplicate but xpath is different"
  pending "is valid if xpath is duplicate but url is different"
  # describe "with duplicate url" do
  #   before :each do
  #     @fb = FactoryGirl.create(:site)
  #     @dup_site = FactoryGirl.build(:site)
  #   end
  #   
  #   it "is invalid without a unique url" do
  #     @dup_site.should_not be_valid
  #   end
  #   
  #   it "is invalid if url isn't unique (case insensitive)" do
  #     @dup_site.name.upcase!
  #     @dup_site.should_not be_valid
  #   end
  # end
end