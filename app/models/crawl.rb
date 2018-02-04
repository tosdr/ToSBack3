# == Schema Information
#
# Table name: crawls
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  full_page      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  crawled_policy :text
#

class Crawl < ApplicationRecord
  belongs_to :policy

  #attr_accessible :crawled_policy, :full_page
  
  validates :policy_id, presence: true, uniqueness: true
end
