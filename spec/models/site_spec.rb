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

RSpec.describe Site do
  let(:site) { FactoryBot.create(:site) }

  it "has a valid factory" do
    expect(site).to be_valid
  end

  it "is invalid without a url" do
    expect(FactoryBot.build(:site, name: nil)).not_to be_valid
  end
  
  it 'responds to policies' do
    expect(site).to respond_to(:policies)
  end  
  it 'responds to commitments' do
    expect(site).to respond_to(:commitments)
  end
    
  describe "#validates uniqueness" do
    let(:dup_site) { FactoryBot.build(:site, name: site.name) }
        
    it "is invalid without a unique url" do
      expect(dup_site).not_to be_valid
    end
    
    it "is invalid if url isn't unique (case insensitive)" do
      dup_site.name.upcase!
      expect(dup_site).not_to be_valid
    end
  end #validates uniqueness  

  describe ".reviewed" do
    let!(:site) { FactoryBot.create(:site_with_policies) }
    it "scopes to sites with reviewed policies" do
      site.policies[0].needs_revision = true
      site.policies[0].save
      # Would be 6 before save due to policy factory creating sites too
      expect(Site.reviewed.count).to eq(5)
    end
  end
end
