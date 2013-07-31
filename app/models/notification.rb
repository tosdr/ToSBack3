class Notification < ActiveRecord::Base
  attr_accessible :name, :site, :diff_url
  
  default_scope order("created_at DESC")
  
  validates :name, :site, :diff_url, presence: true
    
  def image_from_sitename
    "logo/" + site.gsub(/\.([^.]*)$/,".png")
  end
end
