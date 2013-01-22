class Policy < ActiveRecord::Base
  has_many :commitments
  has_many :sites, through: :commitments
  has_many :versions
  has_one :crawl
  
  attr_accessible :detail, :lang, :name, :url, :xpath
  
  validates :name, :url, presence: true
  validates :xpath, uniqueness: {:scope => :url}
  
  after_create do |p|
    p.versions.create(previous_crawl: "Current Version")
  end
end
