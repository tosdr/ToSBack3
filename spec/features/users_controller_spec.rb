require 'spec_helper'

describe "UsersController" do
  subject { page }
  
  describe "visiting signup_path" do
    before { visit signup_path }
    
    it { should have_field("user_name") }
    it { should have_field("user_email") }
    it { should have_field("user_password") }
    it { should have_field("user_password_confirmation") }
    it { should have_button("Create") }
    
    describe "signing up" do
      before do
        @user = FactoryGirl.build(:user)
        fill_in "user_name", with: @user.name
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: @user.password
      end
      
      context "with valid info" do
        before do 
          fill_in "user_password_confirmation", with: @user.password_confirmation
          click_button "Create"
        end

        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out', href: signout_path) }
      end
      
      context "with invalid user info" do
        before do
          fill_in "user_password_confirmation", with: @user.password_confirmation.upcase
          click_button "Create"
        end
        
        it { should have_selector('div.alert.alert-error', text: 'error') }
      end #with invalid info
      
    end #signing up
    
  end #visiting signup_path
  
end