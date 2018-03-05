# == Schema Information
#
# Table name: policies
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  lang           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  needs_revision :boolean
#  xpath          :string
#  obsolete       :boolean
#

class Policy < ApplicationRecord
  has_many :commitments, inverse_of: :policy
  has_many :sites, through: :commitments
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :versions, inverse_of: :policy
  has_one :crawl
  
  validates :name, :url, presence: true

  def self.reviewed
    where(needs_revision: nil)
  end

  #TODO null object pattern instead of string to make behavior consistent
  def current_version
    versions.first || "Sorry, there don't seem to be any versions of this policy stored!"
  end

  #after_create do |p|
    #p.update_current_version
  #end
  
  #before_update do |p|
    #p.update_current_version if p.needs_new_version?
  #end
  
  protected
  
  #def update_current_version
    #unless versions.empty?
      #old_version = versions.first # because of default scope order of versions
      #old_version.update_attributes(previous_policy: detail_was)
    #end
      
    #versions.create(previous_policy: "Current Version")
  #end
  
  #def needs_new_version?
    #detail_changed?
  #end
end
