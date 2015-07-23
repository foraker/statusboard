class Tweet < ActiveRecord::Base
  validates :twitter_id, :author, :tweet, :published_at, presence: true

  def self.latest(count)
    order(:published_at).reverse_order.limit(count)
  end
end
