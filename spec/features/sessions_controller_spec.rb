require 'spec_helper'

RSpec.describe "SessionsController" do
  subject { page }
  
  describe "visiting signin_path" do
    before { visit new_user_session_path }

    it { should have_selector('h2', text: "Log in") }
    it { should have_link('Sign up', href: new_user_registration_path) }
    it { should have_button("Log in") }
    
    describe "signing in" do
      before (:all) { @user = FactoryBot.create(:user) }
      after (:all) { @user.destroy }
      #let!(:user) { FactoryBot.create(:user) }
      
      context "when login info is invalid" do
        before { click_button "Log in"}
        
        it { is_expected.to have_selector('div.alert.alert-alert', text: 'Invalid') }
        
        it "url remains at /signin instead of /sessions" do
          expect(current_path).to eq(new_user_session_path)
        end
        
        context "when visiting another page after a login failure" do
          before { click_link "Sign up"}
          
          it { should_not have_selector('div.alert.alert-alert', text: 'Invalid') }
        end
        
      end #invalid login info
      
      context "when login info is valid" do        
        before do
          #binding.pry
          sign_in @user
        end

        it { is_expected.to have_selector('div.alert.alert-notice', text: 'Signed in') }
        
        it_behaves_like "it has signed in header links" do  # in partials_spec.rb
          let(:user_id) {@user.id}
        end
        
        context "clicking sign out" do
          before { click_link "Sign out" }
          
          it { is_expected.to have_selector('div.alert.alert-notice', text: 'Signed out') }
          it_behaves_like "it has signed out header links"
        end
        
      end #valid login
    end #signing in
    
  end #visiting signin_path
end
