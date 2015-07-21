module Importers
  class GithubImporter
    def initialize(options = Rails.application.secrets)
      self.github = Github.new user: "foraker", oauth_token: options.github_oauth
    end

    def import
      prs = issues.select(&:pull_request?)
      pulls = PullRequestImporter.wrap(prs, github)
      pulls.each do |pull|
        pull.import
      end
    end

    def unapproved_pull_requests
      pull_requests.reject(&:approved?)
    end

    private

    attr_accessor :github

    def issues
      github.issues.list(org: 'foraker', filter: 'all')
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
      PullRequest.where(github_id: github_id).
        create_with(
          github_id:    github_id,
          repository:   repository_name,
          title:        title,
          author:       user_login,
          size:         commit_size,
          thumbs:       thumbs,
          url:          url,
          published_at: published_at
        ).first_or_create
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
      details.additions + details.deletions
    end

    def details
      @details ||= api_client.pull_requests.get 'foraker', repository_name, number
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
