class Version < ActiveRecord::Base
  belongs_to :policy
  
  attr_accessible :policy_id, :previous_crawl
  
  validates :policy_id, :previous_crawl, presence: true
end
