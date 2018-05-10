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

RSpec.describe User do
  let(:user) { FactoryBot.build(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end
  
  xit { should respond_to(:subscriptions) }
  xit { should respond_to(:policies) }
      
  describe "#validates" do
    it "is invalid without a email address" do
      user.email = '         '
      expect(user).not_to be_valid
    end
     
    it "is invalid without a password" do
      user.password = ' '
      user.password_confirmation = ' '
      expect(user).not_to be_valid
    end
     
    it "is invalid if the password confirmation doesn't match" do
      expect(FactoryBot.build(:user, password_confirmation: " ")).not_to be_valid
    end
     
    it "is invalid if the password is too short" do
      expect(FactoryBot.build(:user, password: ("e" * 5), password_confirmation: ("e" * 5))).to_not be_valid
    end
  end # validates
end
