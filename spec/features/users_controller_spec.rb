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
        
        it_behaves_like "it has signed in header links" do
          let(:user_id) { User.last.id }
        end
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

  describe "editing account info" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      visit edit_user_path(@user)
    end
    
    context "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "user_name",             with: new_name
        fill_in "user_email",            with: new_email
        fill_in "user_password",         with: @user.password
        fill_in "user_password_confirmation", with: @user.password
        click_button "Save"
      end

      it { should have_selector('div.alert.alert-success', text: 'saved') }
      specify { @user.reload.name.should  == new_name }
      specify { @user.reload.email.should == new_email }
      
    end # with valid info

    context "with invalid information" do
      before { click_button "Save" }
      
      it { should have_selector('div.alert.alert-error', text: 'error') }
    end #with invalid information
  end #editing account  
  
end