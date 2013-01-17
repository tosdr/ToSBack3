require 'spec_helper'

describe Version do
  let(:version) { FactoryGirl.create(:version) }
  
  it "has a valid factory" do
    version.should be_valid
  end
end