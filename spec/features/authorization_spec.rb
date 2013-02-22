require 'spec_helper'

describe "Authorization" do
  subject { page }
  
  describe "editing user info" do
    before do
      @user = FactoryGirl.create(:user)
    end
    
    context "when not signed in" do
      before { visit edit_user_path(@user) }
      
      it "redirects to signin_path" do
        current_path.should eq(signin_path)
      end

      it { should have_selector('div.alert.alert-notice', text: 'sign in') }
    end #when not signed in
    
    context "when signed in" do
      before { sign_in @user }
      
      context "visiting current_user's account settings" do
        before do
          visit edit_user_path(@user)
        end

        it { should have_selector('h2', text: "Edit") }
      end
      
      context "doing someting unauthorized" do
        before { @otheruser = FactoryGirl.create(:user, email: "other@other.com") }
        
        context "visiting another user's settings" do
          before { visit edit_user_path(@otheruser) }
          
          it "redirects to root" do
            current_path.should eq(root_path)
          end
        end # visiting another user's settings
      
        context "trying to update the wrong user" do
          before { put user_path(@otheruser) }        
          
          specify { response.should redirect_to(root_path) }
        end #trying to update the wrong user

      end # doing something unauthorized
    end # when signed in
  end # in UsersController
end