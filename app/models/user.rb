class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image

  has_many :rooms, dependent: :destroy
  has_many :reservations
  validates :username, presence: true, length: { maximum: 20 }
  validates :profile, length: { maximum: 200 }
end
