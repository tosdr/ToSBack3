# == Schema Information
#
# Table name: versions
#
#  id          :integer          not null, primary key
#  policy_id   :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  full_page   :text
#  former_site :string
#  diff_url    :string
#

require 'spec_helper'

RSpec.describe Version do
  let(:version) { FactoryBot.build(:version) }
  
  it "has a valid factory" do
    expect(version).to be_valid
  end
  
  it 'responds to policy' do
    expect(version).to respond_to(:policy)
  end
  
  describe "#validates presence" do
    it "is invalid without a policy_id" do
      version.policy_id = nil
      expect(version).not_to be_valid
    end
    
    it "is invalid without text" do
      version.text = "   "
      expect(version).not_to be_valid
    end
  end #validates presence

  describe "default order" do
    let!(:older_version) { FactoryBot.create(:version, created_at: 1.day.ago) }
    let!(:newer_version) { FactoryBot.create(:version, policy: older_version.policy) }
    let!(:oldest_version) { FactoryBot.create(:version, created_at: 3.day.ago, policy: older_version.policy) }

    it "uses created_at to determine newest version" do
      expect(Version.first).to eq(newer_version)
    end
  end
end
