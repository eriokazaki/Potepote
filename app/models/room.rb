class Room < ApplicationRecord
has_one_attached :image
validates :name , presence: true
validates :address , presence: true
validates :fee , presence: true , numericality: { greater_than_or_equal_to: 0 }
belongs_to :user , optional: true

has_many :reservations 

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "fee", "id", "image", "introduction", "name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["reservations", "user"]
  end

  def self.search(search)
    if search != ""
      Room.where(['room_name LIKE(?) OR introduction LIKE(?) OR address LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Room.all
    end
  end
end
