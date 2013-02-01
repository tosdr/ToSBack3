# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  previous_crawl :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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
    
    it "is invalid without previous_crawl" do
      version.previous_crawl = "   "
      version.should_not be_valid
    end
  end
  
  describe "#new_version_for(policy_id)" do
    before { Version.new_version_for(version.policy_id, "detail_being_replaced")}
    
    it "creates a new row in the versions table representing the current version"
      
    it "stores the version passed to the method as a policy attribute"
  
    it "moves the old version into the older row in the versions table"
  end
end