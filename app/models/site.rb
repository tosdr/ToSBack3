class Site < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
