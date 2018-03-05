# == Schema Information
#
# Table name: commitments
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :commitment, :class => 'Commitment' do
    policy
    site
  end
end
