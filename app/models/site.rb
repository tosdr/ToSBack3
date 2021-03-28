# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ApplicationRecord
  has_many :commitments, inverse_of: :site
  has_many :policies, through: :commitments
  #attr_accessible :name
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.reviewed
    joins(:policies).merge(Policy.reviewed).distinct
  end
end
