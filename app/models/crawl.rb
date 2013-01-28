# == Schema Information
#
# Table name: crawls
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  scrape     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Crawl < ActiveRecord::Base
  belongs_to :policy

  attr_accessible :crawl, :policy_id
  
  validates :policy_id, presence: true, uniqueness: true
end
