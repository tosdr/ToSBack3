# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  has_many :commitments
  has_many :policies, through: :commitments
  attr_accessible :name
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.reviewed
    joins(:policies).merge(Policy.reviewed).uniq
    #joins(:policies).where(policies: {needs_revision: nil}).uniq
  end
end
