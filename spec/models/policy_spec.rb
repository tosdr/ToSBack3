# == Schema Information
#
# Table name: policies
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :string(255)
#  xpath          :string(255)
#  lang           :string(255)
#  detail         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  needs_revision :boolean
#

require 'spec_helper'

describe Policy do
  it "has a valid factory" do
    FactoryGirl.build(:policy).should be_valid
  end
  
  # let(:example) { FactoryGirl.create(:policy) }
  before(:each) { @example = FactoryGirl.create(:policy) }
    
  it { should respond_to(:sites) }
  it { should respond_to(:commitments) }
  it { should respond_to(:versions) }
  it { should respond_to(:crawl) }
  it { should respond_to(:subscriptions) }
  it { should respond_to(:users) }
  
  it "creates an initial version automatically" do
    @example.versions.count.should eq(1)
  end
  
  describe "#validates presence" do
    it "is invalid without a name" do
      FactoryGirl.build(:policy, name: nil).should_not be_valid
    end 
    it "is invalid without a url" do
      FactoryGirl.build(:policy, url: nil).should_not be_valid
    end
  end # validates
  
  describe "creating duplicate policy" do
    # let(:dup) { FactoryGirl.build(:policy, url: @example.url, xpath: @example.xpath) } # using before to be more consistent
    before(:each) { @dup = FactoryGirl.build(:policy, url: @example.url, xpath: @example.xpath) }
  
    it "is invalid if it has duplicate url and xpath" do
      @dup.should_not be_valid
    end
    it "is valid if url is duplicate but xpath is different" do
      @dup.xpath = "//div[@id='xxxxx']"
      @dup.should be_valid
    end
    it "is valid if xpath is duplicate but url is different" do
      @dup.url = "http://ex.com/terms"
      @dup.should be_valid
    end
  end # when policy is dup
  
  describe "updating a policy" do
    before (:all) { @modified = FactoryGirl.create(:policy) }
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
    let!(:policies) { FactoryGirl.create_list(:policy, 3) }
    it "scopes to policies with needs_revision == nil" do
      policies[0].needs_revision = nil
      policies[0].save
      expect(Policy.reviewed.count).to eq(1)
    end
  end
end
