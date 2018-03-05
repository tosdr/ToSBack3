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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :version do
    sequence(:text) { |n| "Crawl Data #{n}" }
    sequence(:xpath) { |n| "//div[@id='content_#{n}']" }
    policy
  end
end
