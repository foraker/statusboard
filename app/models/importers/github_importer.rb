module Importers
  class GithubImporter
    def initialize(options = Rails.application.secrets)
      self.github = Github.new user: options.github_user, oauth_token: options.github_oauth
    end

    def import
      mark_closed_pull_requests
      pull_request_importers.each do |importer|
        importer.import
      end
    end

    private

    attr_accessor :github

    def issues(options = Rails.application.secrets)
      github.issues.list(org: options.github_org, filter: 'all')
    end

    def pull_request_importers
      PullRequestImporter.wrap(pull_requests, github)
    end

    def pull_requests
      @pull_requests ||= issues.select(&:pull_request?)
    end

    def mark_closed_pull_requests
      PullRequest.where_github_id_not_in(pull_requests.map(&:id).map(&:to_s)).
        update_all(closed_at: Time.now)
    end
  end

  class PullRequestImporter
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

    def import
      pull = PullRequest.where(github_id: github_id).first_or_create
      pull.update_attributes(params)
      pull.save
    end

    def params
      {
        repository:   repository_name,
        title:        title,
        author:       user_login,
        size:         commit_size,
        thumbs:       thumbs,
        url:          url,
        published_at: published_at,
        closed_at:    nil
      }
    end

    def thumbs
      @thumbs ||= comments.sum do |comment|
        comment.body.scan(/👍|🍤|🐑|🚢|⛵|🚚|🍰|🎂|:shipit:/).length
      end
    end

    def repository_name
      name
    end

    def commit_size
      details.additions + details.deletions
    end

    def details(options = Rails.application.secrets)
      @details ||= api_client.pull_requests.get options.github_user, repository_name, number
    end

    def github_id
      pull_request.id
    end

    def published_at
      pull_request.created_at
    end

    def url
      pull_request.html_url
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
end
