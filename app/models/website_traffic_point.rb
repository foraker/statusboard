class WebsiteTrafficPoint < ActiveRecord::Base
  validates :date, :visitors, :pageviews, :sessions, presence: true
  self.table_name = "website_analytics"

  def self.latest(count)
    order(:date).reverse_order.limit(count)
  end
end
