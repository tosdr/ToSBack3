# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  full_page  :text
#  xpath      :string(255)
#

require 'spec_helper'

describe Version do
  let(:version) { FactoryGirl.build(:version) }
  
  it "has a valid factory" do
    version.should be_valid
  end
  
  it { should respond_to(:policy) }
  #it { should respond_to(:changes_from_previous) }
  
  describe "#validates presence" do
    it "is invalid without a policy_id" do
      version.policy_id = nil
      version.should_not be_valid
    end
    
    it "is invalid without text" do
      version.text = "   "
      version.should_not be_valid
    end
  end #validates presence
  
  #describe "changes_from_previous()" do
    ## policy model has a callback that creates a version 'current version' so
    ## @policy really has 4 versions below even though versions_count is 3
    ## see factories/policies.rb for details on differences between versions
    #let(:vcount) { 3 }
    
    #before(:each) { @policy = FactoryGirl.create(:policy_with_sites_and_versions, sites_count: 1, versions_count: vcount) } 
    #let(:original_detail) { FactoryGirl.attributes_for(:policy)[:detail] }
        
    #it "current versions use policy.detail instead of previous_policy's 'Current Version'" do
      #@version = @policy.versions.first
      #@version.changes_from_previous.should eq(Diffy::Diff.new(@policy.detail[0..-2], @policy.detail).to_s(:html))
    #end
    
    #context "with a newer better policy.detail" do
      #before(:each) do
        #@policy.detail = "newer better policy"
        #@policy.save
        #@policy.reload
      #end
      
      #it "newest version diffs policy.detail with version.previous_policy" do
        #@version = @policy.versions.first
        #@version.changes_from_previous.should eq(Diffy::Diff.new(original_detail, "newer better policy").to_s(:html))
      #end
      
      #it "earliest version returns original policy detail (version.previous_policy)" do
        #@version = @policy.versions.last
        #@version.changes_from_previous.should eq(Diffy::Diff.new(original_detail[0..-(vcount+1)], original_detail[0..-(vcount+1)]).to_s(:html))
      #end
    #end
    
  #end
end
