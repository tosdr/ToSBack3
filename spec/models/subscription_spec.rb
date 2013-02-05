require 'spec_helper'

describe Subscription do
  it "has a valid factory" do
    FactoryGirl.build(:subscription).should be_valid
  end
  
  it { should respond_to(:policy) }
  it { should respond_to(:user) }
  
  describe "#validates" do    
    it "is invalid without user_id" do
      FactoryGirl.build(:subscription, user_id: nil).should_not be_valid
    end
    
    it "is invalid without policy_id" do
      FactoryGirl.build(:subscription, policy_id: nil).should_not be_valid
    end
    
    context "when row exists in database" do
      before (:all) { @existing_subscription = FactoryGirl.create(:subscription) }
      after (:all) { Subscription.destroy_all }

      it "is is invalid if the user and policy ids are both duplicates" do
        FactoryGirl.build(:subscription, user_id: @existing_subscription.user_id, policy_id: @existing_subscription.policy_id).should_not be_valid
      end
      
      it "is valid if user_id is unique and policy_id exists" do
        FactoryGirl.build(:subscription, policy_id: @existing_subscription.policy_id, user_id: 25).should be_valid
      end
      
      it "is valid if policy_id is unique and user_id exists" do
        FactoryGirl.build(:subscription, user_id: @existing_subscription.user_id, policy_id: 25).should be_valid
      end
    end
  end #validates
  
end