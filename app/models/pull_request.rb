class PullRequest < ActiveRecord::Base
  validates :repository, :title, :author, :size, :thumbs, presence: true

  def self.latest(count)
    order(:published_at).reverse_order.limit(count)
  end
end
