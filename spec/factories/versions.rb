# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :version do
    sequence(:previous_policy) { |n| "Crawl Data #{n}" }
    policy
  end
end
