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

RSpec.describe Crawl do
  let(:crawl) { FactoryBot.create(:crawl) }
  #before(:each) { @crawl = FactoryBot.create(:crawl) }
  
  it 'responds to policy' do
    expect(crawl).to respond_to(:policy)
  end
  
  it "has a valid factory" do
    expect(crawl).to be_valid
  end
    
  it "is invalid without a policy_id" do
    crawl.policy_id = nil
    expect(crawl).not_to be_valid
  end
  
  context "when crawl exists already" do
    let(:dup) { FactoryBot.build(:crawl, policy_id: crawl.policy_id) }
    #before(:each) { @dup = FactoryBot.build(:crawl, policy_id: @crawl.policy_id) }
    
    it "is invalid with a duplicate policy_id" do
      expect(dup).not_to be_valid
    end
  end
end
