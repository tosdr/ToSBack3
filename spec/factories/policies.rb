# == Schema Information
#
# Table name: policies
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  lang           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  needs_revision :boolean
#  xpath          :string
#  obsolete       :boolean
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :policy do
    sequence(:name) { |n| "Privacy Policy #{n}" }
    sequence(:url) { |n| "http://www.example#{n}.com/privacy" }
    lang "EN"
    needs_revision true
    ignore do
      sites_count 1
      versions_count 0
    end
    
    factory :policy_with_sites_and_versions do
      ignore do
        sites_count 5
        versions_count 5
      end
    end #with_sites

    after(:build) do |policy, eval|
      eval.sites_count.times { policy.sites << FactoryBot.create(:site) }
      eval.versions_count.times do |n| 
        policy.versions << FactoryBot.create(:version, policy: policy, text: "<p>Policy info!</p>" * (n + 1), created_at: (n+1).days.ago)
      end
    end
    
  end
end
