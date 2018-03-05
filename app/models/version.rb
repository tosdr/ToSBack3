# == Schema Information
#
# Table name: versions
#
#  id          :integer          not null, primary key
#  policy_id   :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  full_page   :text
#  former_site :string
#  diff_url    :string
#

class Version < ApplicationRecord
  belongs_to :policy, inverse_of: :versions
  
  default_scope { order("versions.created_at DESC") }
  
  #attr_accessible :previous_policy, :full_page
  
  validates :policy, :text, presence: true
  
  protected
  
  #TODO both methods not needed?
  def previous_version
    policy.versions.where("created_at < ?", created_at).first #returns nil when no previous versions
  end
  
  def current_version?
    self == policy.versions.first
  end
  
end
