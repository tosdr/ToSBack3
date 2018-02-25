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

class Commitment < ApplicationRecord
  belongs_to :site, inverse_of: :commitments
  belongs_to :policy, inverse_of: :commitments
  #attr_protected :policy_id, :site_id
  
  #commented out next line due to problems validating new policies
  #validates :policy_id, :site_id, presence: true
  validates :policy_id, uniqueness: {:scope => :site_id, :message => "This site already has this policy"}
end
