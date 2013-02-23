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
        
        it "url remains at /signin instead of /sessions" do
          current_path.should eq(signin_path)
        end
        
        context "when visiting another page after a login failure" do
          before { click_link "sign up"}
          
          it { should_not have_selector('div.alert.alert-error', text: 'invalid') }
        end
        
      end #invalid login info
      
      context "when login info is valid" do        
        before do
          sign_in @user
        end

        it { should have_selector('div.alert.alert-success', text: 'signed in') }
        it { should have_selector('h2', text: @user.name) }
        
        it_behaves_like "it has signed in header links" do  # in partials_spec.rb
          let(:user_id) {@user.id}
        end
        
        context "clicking sign out" do
          before { click_link "Sign out" }
          
          it { should have_selector('div.alert.alert-success', text: 'signed out') }
          it_behaves_like "it has signed out header links"
        end
        
      end #valid login
    end #signing in
    
  end #visiting signin_path
end