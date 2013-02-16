require 'spec_helper'

describe "UsersController" do
  subject { page }
  
  describe "visiting signup_path" do
    before { visit signup_path }
    
    it { should have_button("Create") }
    
    describe "signing up" do
      context "with valid info" do
        pending "creates a new user"
        pending "automatically signs in user"
      end
      
      context "with invalid user info" do
        pending "displays user.errors"
      end #with invalid info
      
    end #signing up
    
  end #visiting signup_path
  
end