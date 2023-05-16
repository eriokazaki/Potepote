class Room < ApplicationRecord
has_one_attached :image
validates :name , presence: true
validates :address , presence: true
validates :fee , presence: true , numericality: { greater_than_or_equal_to: 0 }

belongs_to :user , optional: true

has_many :reservations 

end
