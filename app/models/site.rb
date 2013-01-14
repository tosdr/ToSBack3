class Site < ActiveRecord::Base
  has_many :commitments
  has_many :policies, through: :commitments
  attr_accessible :name
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
