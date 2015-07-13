class GithubComponent
  def initialize(options = Rails.application.secrets)
    self.github = Github.new user: "foraker", oauth_token: options.github_oauth
  end

  def pull_requests
    prs = issues.select(&:pull_request?)
    PullRequest.wrap(prs, github)
  end

  private

  attr_accessor :github

  def issues
    github.issues.list(org: 'foraker', filter: 'all')
  end
end

class PullRequest
  def self.wrap(pull_requests, api_client)
    pull_requests.map { |pr| self.new(pr, api_client) }
  end

  delegate :size, :number, :title, :html_url, :repository, :user, to: :pull_request
  delegate :name, to: :repository
  delegate :login, :avatar_url, to: :user, prefix: true

  def initialize(pull_request, api_client)
    @pull_request = pull_request
    @api_client = api_client
  end

  def thumbs
    @thumbs ||= comments.sum do |comment|
      comment.body.scan(/:\+1:/).length
    end
  end

  def approved?
    thumbs > 1
  end

  def repository_name
    name.capitalize
  end

  def commit_size
    pull_request_files.additions + pull_request_files.deletions
  end

  def pull_request_files
    @pull_request_files = api_client.pull_requests.get 'foraker', repository_name, number
  end

  private

  attr_reader :pull_request, :api_client

  def comments
    api_client.issues.comments.list(
      owner: 'foraker',
      repo: name,
      number: number
    )
  end
end
