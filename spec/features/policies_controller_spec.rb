require 'spec_helper'

describe "PoliciesController" do
  describe "policies_path#index" do
    before(:all) { 31.times { FactoryGirl.create(:policy) } }
    after(:all)  { Policy.delete_all }

    before(:each) do
      visit policies_path
    end

    it "contains first policy" do
      page.should have_selector('li', text: Policy.first.name)
    end

    it "doesn't contain the 31st policy (pagination)" do
      page.should_not have_selector('li', text: Policy.last.name)
    end

    it "lists page numbers" do
      page.should have_selector('div.pagination')
    end

    it "links to policy_path(:id)" do
      page.should have_link(Policy.first.name, href: policy_path(Policy.first))
    end
  end
end