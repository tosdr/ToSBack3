# == Schema Information
#
# Table name: policies
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :string(255)
#  xpath          :string(255)
#  lang           :string(255)
#  detail         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  needs_revision :boolean
#

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
  
  protected
  
  def needs_new_version?
    
  end
end
