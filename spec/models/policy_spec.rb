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
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:policy).should be_valid
  end
  
  let!(:example) { FactoryGirl.create(:policy) }
  
  it { should respond_to(:sites) }
  it { should respond_to(:commitments) }
  it { should respond_to(:versions) }
  it { should respond_to(:crawl) }
  
  it "creates an initial version automatically" do
    example.versions.count.should eq(1)
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
    let(:dup) { FactoryGirl.build(:policy, url: example.url, xpath: example.xpath) }
  
    it "is invalid if it has duplicate url and xpath" do
      dup.should_not be_valid
    end
    it "is valid if url is duplicate but xpath is different" do
      dup.xpath = "//div[@id='xxxxx']"
      dup.should be_valid
    end
    it "is valid if xpath is duplicate but url is different" do
      dup.url = "http://ex.com/terms"
      dup.should be_valid
    end
  end # when policy is dup
  
  describe "updating a policy" do
    context "when policy name is changed" do
      before (:each) { example.name = "something new" }
      
      it "needs_new_version? returns false" do
        example.send(:needs_new_version?).should eq(false)
      end
      
      it "doesn't add a new version when saved" do
        expect{example.save}.to_not change{example.versions.count}.by(1)
      end
    end
    
    context "when policy detail is changed" do
      before (:each) { example.detail = "new crawl" }
      
      it "needs_new_version? returns true" do
        example.send(:needs_new_version?).should eq(true)
      end
      
      context "and policy is saved" do
        before (:all) do 
          @old_data = example.detail_was
          example.save
        end
      
        it "adds a new version when saved" do
          example.versions.count.should eq(2)
        end
      
        specify "second to last version equals old policy detail" do
          example.versions[-2].previous_crawl.should eq(@old_data)
        end
      
        specify "most recent version represents current version" do
          example.versions.last.previous_crawl.should eq("Current Version")
        end
      end # policy is saved
    end 
    
  end # updating a policy
end
