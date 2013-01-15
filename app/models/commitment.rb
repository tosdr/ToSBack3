class Commitment < ActiveRecord::Base
  belongs_to :site
  belongs_to :policy
  attr_accessible :policy_id, :site_id
  
  validates :policy_id, :site_id, presence: true
  validates :policy_id, uniqueness: {:scope => :site_id, :message => "This site already has this policy"}
end
