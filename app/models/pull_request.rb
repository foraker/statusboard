class PullRequest < ActiveRecord::Base
  validates :repository, :title, :author, :size, :thumbs, presence: true

  def self.active
    where(closed_at: nil)
  end

  def self.ordered
    order(:published_at).reverse_order
  end

  def self.approved
    all.select(&:approved?)
  end

  def self.unapproved
    all.reject(&:approved?)
  end

  def self.for_repository(repository)
    where(repository: repository)
  end

  def self.where_github_id_not_in(github_ids)
    where("#{table_name}.github_id NOT IN (?)", github_ids)
  end

  def approved?
    thumbs >= 2
  end
end
