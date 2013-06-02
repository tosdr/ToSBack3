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
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :versions
  has_one :crawl
  
  attr_accessible :detail, :lang, :name, :url, :xpath
  
  validates :name, :url, presence: true
  validates :xpath, uniqueness: {:scope => :url}
  
  after_create do |p|
    p.update_current_version
  end
  
  before_update do |p|
    p.update_current_version if p.needs_new_version?
  end
  
  protected
  
  def update_current_version
    unless versions.empty?
      old_version = versions.first # because of default scope order of versions
      old_version.update_attributes(previous_policy: detail_was)
    end
      
    versions.create(previous_policy: "Current Version")
  end
  
  def needs_new_version?
    detail_changed?
  end
end
