# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :version do
    sequence(:text) { |n| "Crawl Data #{n}" }
    sequence(:xpath) { |n| "//div[@id='content_#{n}']" }
    policy
  end
end
