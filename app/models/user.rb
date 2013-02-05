# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :policies, through: :subscriptions
  
  attr_accessible :email, :name
  
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
