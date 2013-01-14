class Policy < ActiveRecord::Base
  has_many :sites, through: :commitments
  attr_accessible :crawl, :lang, :name, :url, :xpath
  
  validates :name, :url, presence: true
  validates :xpath, uniqueness: {:scope => :url}
end
