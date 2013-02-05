# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end
      
  describe "#validates" do
     it "is invalid without a name" do
       FactoryGirl.build(:user, name: nil).should_not be_valid
     end
     
     it "is invalid without a email address" do
       FactoryGirl.build(:user, email: nil).should_not be_valid
     end
     
     context "when user exists in database" do
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
end