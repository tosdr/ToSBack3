# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "john.doe@ihopethisisafakedomain.com"
    admin false
  end
end
