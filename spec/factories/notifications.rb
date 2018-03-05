# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  site       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diff_url   :string
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :notification do
    site "example.com"
    name "Privacy Policy"
    diff_url "http://example.com/some_diff_url"
  end
end
