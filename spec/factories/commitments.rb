# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commitment, :class => 'Commitment' do
    policy_id 1
    site_id 1
  end
end
