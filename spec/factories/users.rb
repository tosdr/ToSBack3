# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
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
