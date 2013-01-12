class Commitment < ActiveRecord::Base
  attr_accessible :policy_id, :site_id
  
  validates :policy_id, :site_id, presence: true
  validates :policy_id, uniqueness: {:scope => :site_id}
end
