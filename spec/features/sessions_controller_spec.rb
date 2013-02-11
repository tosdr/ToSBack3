require 'spec_helper'

describe "SessionsController" do
  subject { page }
  
  describe "visiting signin_path" do
    before { visit signin_path }
    
    it { should have_button("Sign In") }
    it { should have_button("Create") }

  end
end
