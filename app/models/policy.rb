class Policy < ActiveRecord::Base
  has_many :commitments
  has_many :sites, through: :commitments
  has_many :versions
  attr_accessible :crawl, :lang, :name, :url, :xpath
  
  validates :name, :url, presence: true
  validates :xpath, uniqueness: {:scope => :url}
end
