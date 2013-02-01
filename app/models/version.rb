# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  previous_crawl :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Version < ActiveRecord::Base
  belongs_to :policy
  
  default_scope order("created_at ASC")  
  
  attr_accessible :policy_id, :previous_crawl
  
  validates :policy_id, :previous_crawl, presence: true
end
