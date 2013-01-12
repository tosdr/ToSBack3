class Commitments < ActiveRecord::Base
  attr_accessible :policy_id, :site_id
  
  validates :policy_id, :site_id, presence: true
end
