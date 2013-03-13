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
  it { should respond_to(:changes_from_previous) }
  
  describe "#validates presence" do
    it "is invalid without a policy_id" do
      version.policy_id = nil
      version.should_not be_valid
    end
    
    it "is invalid without previous_crawl" do
      version.previous_crawl = "   "
      version.should_not be_valid
    end
  end #validates presence
  
  describe "changes_from_previous()" do
    before(:each) { @policy = FactoryGirl.create(:policy_with_sites_and_versions, sites_count: 1, versions_count: 3) } #policy model has a callback that creates a version 'current version'
    let(:original_detail) { FactoryGirl.attributes_for(:policy)[:detail] }
        
    it "current versions use policy.detail instead of previous_crawl's 'Current Version'" do
      @version = @policy.versions.first
      @version.changes_from_previous.should eq(@policy.detail)
    end
    
    context "with a newer better policy.detail" do
      before(:each) do
        @policy.detail = "newer better policy"
        @policy.save
        @policy.reload
      end
      
      it "newest version diffs policy.detail with version.previous_crawl" do
        @version = @policy.versions.first
        @version.changes_from_previous.should eq(Differ.diff_by_word("newer better policy", original_detail).format_as(:html))
      end
      
      it "earliest version returns original policy detail (version.previous_crawl)" do
        @version = @policy.versions.last
        @version.changes_from_previous.should eq(original_detail[0..-3])
      end
    end
    
  end
end