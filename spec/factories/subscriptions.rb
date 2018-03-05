# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :subscription do
    policy_id 1
    user_id 1
  end
end
