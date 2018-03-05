# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Site, disabled: true do
  it "has a valid factory" do
    FactoryBot.create(:site).should be_valid
  end

  it "is invalid without a url" do
    FactoryBot.build(:site, name: nil).should_not be_valid
  end
  
  it { should respond_to(:policies) }  
  it { should respond_to(:commitments) }
    
  describe "#validates uniqueness" do
    let!(:example) { FactoryBot.create(:site) }
    let(:dup_site) { FactoryBot.build(:site, name: example.name) }
        
    it "is invalid without a unique url" do
      dup_site.should_not be_valid
    end
    
    it "is invalid if url isn't unique (case insensitive)" do
      dup_site.name.upcase!
      dup_site.should_not be_valid
    end
  end #validates uniqueness  

  describe ".reviewed" do
    let!(:site) { FactoryBot.create(:site_with_policies) }
    it "scopes to sites with reviewed policies" do
      site.policies[0].needs_revision = true
      site.policies[0].save
      # Would be 10 due to policy factory creating sites too
      expect(Site.reviewed.count).to eq(8)
    end
  end
end
