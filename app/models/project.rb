class Project < ActiveRecord::Base
  include PullRequests

  validates :name, :repository, :pivotal_id, presence: true

  has_many :code_climate_scores

  def self.ordered_by_name
    order(:name)
  end

  def self.with_repository(repository)
    where(repository: repository)
  end

  def pull_requests
    PullRequest.for_repository(repository)
  end

  def pivotal_project
    PivotalProject.find_by_pivotal_id(pivotal_id)
  end
end
