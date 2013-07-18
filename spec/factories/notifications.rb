# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    site "example.com"
    name "Privacy Policy"
  end
end
