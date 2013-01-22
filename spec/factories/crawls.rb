# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crawl do
    policy_id 1
    crawl "MyText"
  end
end
