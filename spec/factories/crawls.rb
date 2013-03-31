# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crawl do
    scrape "<h1>Privacy Policy</h1><p>trust.us cares about your privacy</p>"
    policy
  end
end
