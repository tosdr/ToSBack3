require 'spec_helper'

RSpec.describe "PoliciesController" do
  
  subject { page }
  
  describe "visiting #index" do
    before(:all) { 31.times { FactoryBot.create(:policy) } }
    after(:all) do
      Policy.delete_all
      Site.delete_all
      Commitment.delete_all
    end

    before(:each) do
      visit policies_path
    end

    it "contains first policy" do
      expect(page).to have_selector('li', text: Policy.first.name)
    end

    it "doesn't contain the 31st policy (pagination)" do
      expect(page).not_to have_selector('li', text: Policy.last.name)
    end

    it "lists page numbers" do
      expect(page).to have_selector('div.pagination')
    end

    it "links to policy_path(:id)" do
      expect(page).to have_link(Policy.first.name, href: policy_path(Policy.first))
    end
  end # policies_path#index
  
  describe "visiting #show" do

    context "when policy has many sites and versions" do
      before do
        @policy = FactoryBot.create(:policy_with_sites_and_versions, sites_count: 14, versions_count: 17)
        visit policy_path(@policy)
      end
      # let(:changes) { Nokogiri::HTML(page.source).xpath("//div[@id='policy_changes']/node()").to_s }
      
      it { is_expected.to have_selector('h1', text: @policy.name) }
      it { is_expected.to have_selector('a', text: @policy.versions.first.created_at.to_date.strftime("%B %-d, %Y")) }
      
      it "paginates site links to the first 10" do
        @policy.sites.each_with_index do |site, i|
          if i<10
            expect(page).to have_link(site.name, href: site_path(site.id))
            expect(page).to have_selector('li', text: site.name)
          else
            expect(page).not_to have_link(site.name, href: site_path(site.id))
            expect(page).not_to have_selector('li', text: site.name)
          end
        end
      end
      
      it "paginates version links to the first 10" do
        @policy.versions.each_with_index do |version, i|
          if i<10
            expect(page).to have_link(version.created_at.to_date.strftime("%B %-d, %Y"))
          else
            expect(page).not_to have_link(version.created_at.to_date.strftime("%B %-d, %Y"))
          end
        end
      end
      
      it { is_expected.to have_selector('div.pagination') }      
      it { is_expected.to have_selector('div#policy_text') }
      
      context "clicking a link to a different version" do
        before { click_link(@policy.versions[5].created_at.to_date.strftime("%B %-d, %Y")) }
        
        it { is_expected.to have_content(@policy.versions[5].created_at.to_date.strftime("%B %-d, %Y")) }
      end
    end #many 

    context "when policy has no versions" do
      before do
        @policy = FactoryBot.create(:policy_with_sites_and_versions, sites_count: 1, versions_count: 0)
        visit policy_path(@policy)
      end

      it { is_expected.to have_content("Sorry") }
    end #no versions
         
  end #visiting #show
end
