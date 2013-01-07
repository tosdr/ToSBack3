class Policy < ActiveRecord::Base
  attr_accessible :crawl, :lang, :name, :site_id, :url, :xpath
end
