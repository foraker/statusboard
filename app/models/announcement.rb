class Announcement < ActiveRecord::Base
  validates :words, :user, presence: true

  def self.unannounced
    where(announced_at: nil)
  end

  def self.oldest_first
    order(:created_at)
  end

  def announced!
    update_attribute(:announced_at, Time.now)
  end
end
