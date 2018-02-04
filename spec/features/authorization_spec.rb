require 'spec_helper'

RSpec.describe "Authorization", disabled: true do
  subject { page }
  
  describe "editing user info" do
    before do
      @user = FactoryBot.create(:user)
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
      
      context "doing something unauthorized" do
        before { @otheruser = FactoryBot.create(:user, email: "other@other.com") }
        
        context "visiting another user's settings" do
          before { visit edit_user_path(@otheruser) }
          
          it "redirects to root" do
            current_path.should eq(root_path)
          end
        end # visiting another user's settings
        
        context "trying to update the wrong user" do
          let(:user_attrs) { FactoryBot.attributes_for(:user, email: "test@test.com").except!(:admin) } # Can't mass-assign protected attributes: admin
          xit "doesn't update via 'put' request" do
            #unsupported syntax?:
            #expect{ put "/users/#{@otheruser.id}", id: @otheruser.id, user: user_attrs }.to_not change{@otheruser.reload.email}.from("other@other.com").to("test@test.com")
            
            #long version:
            put "/users/#{@otheruser.id}", id: @otheruser.id, user: user_attrs
            @otheruser.reload
            @otheruser.email.should_not eq(user_attrs[:email])
          end
          
        end #trying to update the wrong user

      end # doing something unauthorized
    end # when signed in
  end # in UsersController
end
