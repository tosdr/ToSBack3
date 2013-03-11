# == Schema Information
#
# Table name: commitments
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Commitment < ActiveRecord::Base
  belongs_to :site
  belongs_to :policy
  attr_protected :policy_id, :site_id
  
  validates :policy_id, :site_id, presence: true
  validates :policy_id, uniqueness: {:scope => :site_id, :message => "This site already has this policy"}
end
