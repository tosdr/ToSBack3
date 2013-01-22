class Crawl < ActiveRecord::Base
  belongs_to :policy

  attr_accessible :crawl, :policy_id
  
  validates :policy_id, presence: true, uniqueness: true
end