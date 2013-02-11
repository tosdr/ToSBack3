require 'spec_helper'

describe "SessionsControllers" do
  describe "GET /sessions_controllers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sessions_controllers_path
      response.status.should be(200)
    end
  end
end
