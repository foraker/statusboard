class Node < ActiveRecord::Base
  validates :date, :visitors, :pageviews, :sessions, presence: true
  self.table_name = "foraker_statistics"

  def self.latest(count)
    order(:date).reverse_order.limit(count)
  end
end
