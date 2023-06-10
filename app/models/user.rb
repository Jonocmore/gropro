class User < ApplicationRecord
  has_many :gardens
  has_many :forums
  has_many :messages
  has_many :user_resources
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
