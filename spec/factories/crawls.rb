# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :crawl do
    crawled_policy "<h1>Privacy Policy</h1><p>trust.us cares about your privacy</p>"
    policy
  end
end
