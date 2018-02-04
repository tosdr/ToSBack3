# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Subscription, disabled: true do
  it "has a valid factory" do
    FactoryBot.build(:subscription).should be_valid
  end
  
  it { should respond_to(:policy) }
  it { should respond_to(:user) }
  
  describe "#validates" do    
    it "is invalid without user_id" do
      FactoryBot.build(:subscription, user_id: nil).should_not be_valid
    end
    
    it "is invalid without policy_id" do
      FactoryBot.build(:subscription, policy_id: nil).should_not be_valid
    end
    
    context "when row exists in database" do
      before (:all) { @existing_subscription = FactoryBot.create(:subscription) }
      after (:all) { Subscription.destroy_all }

      it "is is invalid if the user and policy ids are both duplicates" do
        FactoryBot.build(:subscription, user_id: @existing_subscription.user_id, policy_id: @existing_subscription.policy_id).should_not be_valid
      end
      
      it "is valid if user_id is unique and policy_id exists" do
        FactoryBot.build(:subscription, policy_id: @existing_subscription.policy_id, user_id: 25).should be_valid
      end
      
      it "is valid if policy_id is unique and user_id exists" do
        FactoryBot.build(:subscription, user_id: @existing_subscription.user_id, policy_id: 25).should be_valid
      end
    end
  end #validates
  
end
