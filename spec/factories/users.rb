# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "John Doe"
    sequence(:email) {|n| "john.doe#{n}@ihopethisisafakedomain.com" }
    password "dictionary"
    password_confirmation "dictionary"
    # admin false
    
    factory :admin do
      admin true
    end #admin
    
  end
end
