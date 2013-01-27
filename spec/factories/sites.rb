FactoryGirl.define do
  factory :site do
    sequence(:name) {|n| "example#{n}.com"}
  end
end