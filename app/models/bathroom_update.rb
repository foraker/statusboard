class BathroomUpdate < ActiveRecord::Base
  validates :occupied, inclusion: [true, false]
  validates :room, presence: true

  def self.latest
    order(:created_at).last
  end

  def self.by_room(room)
    where(room: room)
  end

  def occupied?
    occupied
  end
end
