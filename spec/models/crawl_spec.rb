# == Schema Information
#
# Table name: crawls
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  full_page      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  crawled_policy :text
#

require 'spec_helper'

describe Crawl do
  # let(:crawl) { FactoryGirl.build(:crawl) }
  before(:each) { @crawl = FactoryGirl.create(:crawl) }
  
  it { should respond_to(:policy) }
  
  it "has a valid factory" do
    @crawl.should be_valid
  end
    
  it "is invalid without a policy_id" do
    @crawl.policy_id = nil
    @crawl.should_not be_valid
  end
  
  context "when crawl exists already" do
    # let!(:current_crawl) { FactoryGirl.create(:crawl) }
    before(:each) { @dup = FactoryGirl.build(:crawl, policy_id: @crawl.policy_id) }
    
    it "is invalid with a duplicate policy_id" do
      @dup.should_not be_valid
    end
  end
end
