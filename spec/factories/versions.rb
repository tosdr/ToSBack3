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
    policy
    sequence(:text) { |n| "Crawl Data #{n}" }
    former_site { nil }
    diff_url { "https://github.com/tosdr/tosback2/commit/bc68a13b5be09be76cf08d62be874d1ca899fa37?diff=split" }
  end
end
