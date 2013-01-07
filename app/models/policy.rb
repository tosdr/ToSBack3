class Policy < ActiveRecord::Base
  attr_accessible :crawl, :lang, :name, :site_id, :url, :xpath
  
  validates :name, :site_id, :url, presence: true
end
