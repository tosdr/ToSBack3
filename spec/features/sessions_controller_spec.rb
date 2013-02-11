require 'spec_helper'

describe "SessionsController" do
  subject { page }
  
  describe "visiting signin_path" do
    before { visit signin_path }

    it { should have_selector('h2', text: "Sign In:") }    
    it { should have_button("Sign In") }
    it { should have_button("Create") }
    
    describe "signing in" do
      before (:all) { @user = FactoryGirl.create(:user) }
      after (:all) { User.destroy_all }
      
      context "when login info is invalid" do
        before { click_button "Sign in"}
        
        it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        
      end #invalid login info
      
      context "when login info is valid" do        
        before do
          fill_in "Email",    with: @user.email.upcase
          fill_in "Password", with: @user.password
          click_button "Sign in"
        end

        it { should have_selector('title', text: @user.name) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
        
      end #valid login
    end #signing in
    
  end #visiting signin_path
end
