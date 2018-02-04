# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :subscription do
    policy_id 1
    user_id 1
  end
end
