# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :version do
    policy_id 1
    sequence(:previous_crawl) { |n| "Crawl Data #{n}" }
  end
end
