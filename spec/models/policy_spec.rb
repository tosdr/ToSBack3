# == Schema Information
#
# Table name: policies
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  lang           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  needs_revision :boolean
#  xpath          :string
#  obsolete       :boolean
#

require 'spec_helper'

RSpec.describe Policy do
  let(:policy) { FactoryBot.create(:policy) }

  it "has a valid factory" do
    expect(policy).to be_valid
  end
  
  #before(:each) { @policy = FactoryBot.create(:policy) }
    
  it 'responds to sites' do
    expect(policy).to respond_to(:sites)
  end
  it 'responds to commitments' do
    expect(policy).to respond_to(:commitments)
  end
  it 'responds to versions' do
    expect(policy).to respond_to(:versions)
  end
  it 'responds to crawl' do
    expect(policy).to respond_to(:crawl)
  end
  it 'responds to subscriptions' do
    expect(policy).to respond_to(:subscriptions)
  end
  it 'responds to users' do
    expect(policy).to respond_to(:users)
  end
  
  describe "#validates presence" do
    it "is invalid without a name" do
      expect(FactoryBot.build(:policy, name: nil)).not_to be_valid
    end 
    it "is invalid without a url" do
      expect(FactoryBot.build(:policy, url: nil)).not_to be_valid
    end
  end # validates
  
  describe "creating duplicate policy" do
    let(:dup) { FactoryBot.build(:policy, url: policy.url, xpath: policy.xpath) }
  
    it "is invalid if it has duplicate url and xpath" do
      expect(dup).not_to be_valid
    end
    it "is valid if url is duplicate but xpath is different" do
      dup.xpath = "//div[@id='xxxxx']"
      expect(dup).to be_valid
    end
    it "is valid if xpath is duplicate but url is different" do
      dup.url = "http://ex.com/terms"
      expect(dup).to be_valid
    end
  end # when policy is dup
  
  #TODO remove when sure we no longer want policy to create versions on update
  describe "updating a policy", disabled: true do
    before (:all) { @modified = FactoryBot.create(:policy) }
    after (:all) {Policy.destroy_all}
    
    context "when policy name is changed" do
      before (:all) { @modified.name = "some new policy name"}
      
      it "needs_new_version? returns false" do
        @modified.send(:needs_new_version?).should eq(false)
      end
      
      it "doesn't add a new version when saved" do
        expect{@modified.save}.to_not change{@modified.versions.count}.by(1)
      end
    end
    
    context "when policy detail is changed" do
      before (:all) { @modified.detail = "new crawl" }
      
      it "needs_new_version? returns true" do
        @modified.send(:needs_new_version?).should eq(true)
      end
      
      context "and policy detail is saved" do
        before (:all) do
          @old_crawl = @modified.detail_was
          @modified.save
        end
      
        it "isn't dirty" do
          @modified.changed?.should eq(false)
        end
      
        it "adds a new version" do
          @modified.versions.count.should eq(2)
        end
      
        specify "second to last version equals old policy detail" do
          @modified.versions[-2].previous_policy.should eq(@old_crawl)
        end
      
        specify "most recent version represents current version" do
          @modified.versions.last.previous_policy.should eq("Current Version")
        end
        
      end # policy is saved
    end 
    
  end # updating a policy

  describe ".reviewed" do
    let!(:policies) { FactoryBot.create_list(:policy, 3) }
    it "scopes to policies with needs_revision == nil" do
      policies[0].needs_revision = false
      policies[0].save
      expect(Policy.reviewed.count).to eq(1)
    end
  end
end
