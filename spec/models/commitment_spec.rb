# == Schema Information
#
# Table name: commitments
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Commitment do
  let(:commitment) { FactoryBot.build(:commitment) }

  it "has a valid factory" do
    expect(commitment).to be_valid
  end
  
  it 'responds to site' do
    expect(commitment).to respond_to(:site)
  end

  it 'responds to policy' do
    expect(commitment).to respond_to(:policy)
  end
  
  describe "#validates" do
    it "is invalid without site_id" do
      commitment.site = nil
      expect(commitment).not_to be_valid
    end
    
    it "is invalid without policy_id" do
      commitment.policy = nil
      expect(commitment).not_to be_valid
    end

    #don't think these are really needed:
    context "when row exists in database", disabled: true do
      let!(:eg) { FactoryBot.create(:commitment) }

      it "is is invalid if the site and policy ids are both duplicates" do
        expect(commitment).not_to be_valid
      end
      
      it "is valid if site id is unique and policy id exists" do
        commitment.site_id = 2
        expect(commitment).to be_valid
      end
      
      it "is valid if policy id is unique and site id exists" do
        commitment.policy_id = 2
        expect(commitment).to be_valid
      end
    end
  end #validates
end
