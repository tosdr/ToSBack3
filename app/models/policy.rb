class Policy < ActiveRecord::Base
  attr_accessible :crawl, :lang, :name, :url, :xpath
  
  validates :name, :url, presence: true
end
