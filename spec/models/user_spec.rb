# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end
  
  it { should respond_to(:subscriptions) }
  it { should respond_to(:policies) }
  it { should respond_to(:password_digest) }
      
  describe "#validates" do
     it "is invalid without a name" do
       FactoryGirl.build(:user, name: nil).should_not be_valid
     end
     
     it "is invalid without a email address" do
       FactoryGirl.build(:user, email: nil).should_not be_valid
     end
     
     context "when user already exists in database, new user" do
       before(:all) { @existing = FactoryGirl.create(:user) }
       after(:all) { User.destroy_all }
       
       it "is valid with the same name" do
         FactoryGirl.build(:user, name: @existing.name).should be_valid
       end
       
       it "is invalid with the same email" do
         FactoryGirl.build(:user, email: @existing.email).should_not be_valid
       end
     end
   end # validates
   
   describe "saving a user" do
     before { @user = FactoryGirl.create(:user, email: "ALLCAPS@CAPSLOCK.COM") }
     
     specify "email should be downcased before saving" do
       @user.email.should eq("allcaps@capslock.com")
     end
   end
end
