class User < ApplicationRecord
  #has_many :subscriptions
  #has_many :policies, through: :subscriptions

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  # :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable
end
