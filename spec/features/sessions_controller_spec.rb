require 'spec_helper'

describe "SessionsController" do
  subject { page }
  
  describe "visiting signin_path" do
    before { visit signin_path }

    it { should have_selector('h2', text: "Sign in") }
    it { should have_link('sign up', href: signup_path) }
    it { should have_button("Sign in") }
    
    describe "signing in" do
      before (:all) { @user = FactoryGirl.create(:user) }
      after (:all) { @user.destroy }
      
      context "when login info is invalid" do
        before { click_button "Sign in"}
        
        it { should have_selector('div.alert.alert-error', text: 'invalid') }
        
        context "when visiting another page after a login failure" do
          before { click_link "sign up"}
          
          it { should_not have_selector('div.alert.alert-error', text: 'invalid') }
        end
        
      end #invalid login info
      
      context "when login info is valid" do        
        before do
          fill_in "login_email",    with: @user.email.upcase
          fill_in "login_password", with: @user.password
          click_button "Sign in"
        end

        it { should have_selector('div.alert.alert-notice', text: 'signed in') }
        it { should have_selector('h2', text: @user.name) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
        
      end #valid login
    end #signing in
    
  end #visiting signin_path
end