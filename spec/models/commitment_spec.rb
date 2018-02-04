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

RSpec.describe Commitment, disabled: true do
  it "has a valid factory" do
    FactoryBot.build(:commitment).should be_valid
  end
  
  it { should respond_to(:site) }
  it { should respond_to(:policy) }
  
  describe "#validates" do
    let(:comm) { FactoryBot.build(:commitment) }
    
    it "is invalid without site_id" do
      FactoryBot.build(:commitment, site_id: nil).should_not be_valid
    end
    
    it "is invalid without policy_id" do
      FactoryBot.build(:commitment, policy_id: nil).should_not be_valid
    end
    
    context "when row exists in database" do
      let!(:eg) { FactoryBot.create(:commitment) }

      it "is is invalid if the site and policy ids are both duplicates" do
        comm.should_not be_valid
      end
      
      it "is valid if site id is unique and policy id exists" do
        comm.site_id = 2
        comm.should be_valid
      end
      
      it "is valid if policy id is unique and site id exists" do
        comm.policy_id = 2
        comm.should be_valid
      end
    end
  end #validates
end
