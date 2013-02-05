class Subscription < ActiveRecord::Base
  belongs_to :policy
  belongs_to :user  
  
  validates :policy_id, :user_id, presence: true
  validates :policy_id, uniqueness: { :scope => :user_id, :message => "Already subscribed to this policy" }
  
  attr_accessible :policy_id, :user_id
end
