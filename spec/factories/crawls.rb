# == Schema Information
#
# Table name: crawls
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  full_page      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  crawled_policy :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :crawl do
    crawled_policy "<h1>Privacy Policy</h1><p>trust.us cares about your privacy</p>"
    policy
  end
end
