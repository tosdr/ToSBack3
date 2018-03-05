# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

require 'spec_helper'

RSpec.describe User, disabled: true do
  it "has a valid factory" do
    FactoryBot.build(:user).should be_valid
  end
  
  it { should respond_to(:subscriptions) }
  it { should respond_to(:policies) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }
      
  describe "#validates" do
    it "is invalid without a name" do
      FactoryBot.build(:user, name: nil).should_not be_valid
    end
    
    it "is invalid with a name longer than 50 chars" do
      FactoryBot.build(:user, name: ("a" * 51)).should_not be_valid
    end     

    it "is invalid without a email address" do
      FactoryBot.build(:user, email: "      ").should_not be_valid
    end
     
    it "is invalid without a password" do
      FactoryBot.build(:user, password: "  ", password_confirmation: "  ").should_not be_valid
    end
     
    it "is invalid if the password confirmation doesn't match" do
      FactoryBot.build(:user, password_confirmation: " ").should_not be_valid
    end
     
    it "is invalid if the password is too short" do
      FactoryBot.build(:user, password: ("e" * 5), password_confirmation: ("e" * 5)).should_not be_valid
    end
    
    specify "malformed email addresses are invalid" do
      %w[user@foo,com user_at_foo.org example.user@foo. foo@foo@bar.com foo@bar+baz.com].each do |invalid_email|
        FactoryBot.build(:user, email: invalid_email).should_not be_valid
      end
    end
    
    specify "proper email addresses are valid" do
      %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn].each do |valid_email|
        FactoryBot.build(:user, email: valid_email).should be_valid
      end
    end
     
    context "when user already exists in database, new user" do
      before(:all) { @existing = FactoryBot.create(:user) }
      after(:all) { User.destroy_all }
      
      it "is valid with the same name" do
        FactoryBot.build(:user, name: @existing.name).should be_valid
      end
       
      it "is invalid with the same email" do
        FactoryBot.build(:user, email: @existing.email).should_not be_valid
      end
    end
  end # validates
   
  describe "saving a user" do
    before { @user = FactoryBot.create(:user, email: "ALLCAPS@CAPSLOCK.COM") }
     
    specify "email should be downcased before saving" do
      @user.email.should eq("allcaps@capslock.com")
    end
  end
end
