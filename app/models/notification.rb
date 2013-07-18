class Notification < ActiveRecord::Base
  attr_accessible :name, :site
  
  default_scope order("created_at DESC")
  
  validates :name, :site, presence: true
    
  def image_from_sitename
    "logo/" + site.gsub(/\..*/,".png")
  end
end
