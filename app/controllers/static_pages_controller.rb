class StaticPagesController < ApplicationController
  def index
    twitter_client = TwitterClient.new

    @tweets = twitter_client.latest_mentions
  end
end
