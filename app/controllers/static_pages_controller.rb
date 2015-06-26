class StaticPagesController < ApplicationController
  def index
    twitter_client = create_twitter_client
    @parser = UrlParser.new

    @tweets = twitter_client.latest_mentions(15)
    @profiles = twitter_client.getProfiles(@tweets)
    @tweet_url = @parser.extract_urls(@tweets[0].full_text)

    github_client = create_github_client
    @pulls = github_client.getIssues
  end

  private

  def create_twitter_client
    TwitterClient.new
  end

  def create_github_client
    GithubClient.new
  end
end
