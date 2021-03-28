# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  site       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diff_url   :string
#

class Notification < ApplicationRecord
  #attr_accessible :name, :site, :diff_url
  
  default_scope { order("created_at DESC") }
  
  validates :name, :site, :diff_url, presence: true
    
  def image_from_sitename
    path = "logo/" + site.gsub(/\.([^.]*)$/,".png")
    return ActionController::Base.helpers.asset_digest_path(path).nil? ? 'logo/default.png' : path
  end
end
