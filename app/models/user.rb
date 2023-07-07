class User < ApplicationRecord
  has_many :gardens
  has_many :forums
  has_many :messages
  has_many :user_resources
  has_one_attached :avatar
  attribute :about, :text
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end
