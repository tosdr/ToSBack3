# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :notification do
    site "example.com"
    name "Privacy Policy"
    diff_url "http://example.com/some_diff_url"
  end
end
