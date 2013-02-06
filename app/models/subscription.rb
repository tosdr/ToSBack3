# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  belongs_to :policy
  belongs_to :user  
  
  validates :policy_id, :user_id, presence: true
  validates :policy_id, uniqueness: { :scope => :user_id, :message => "Already subscribed to this policy" }
  
  attr_accessible :policy_id, :user_id
end
