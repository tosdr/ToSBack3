require 'spec_helper'

describe Site do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    Factory.create(:site).should be_valid
  end
  it "is invalid without a url" do
    Factory.build(:site, name: nil).should_not be_valid
  end
end
