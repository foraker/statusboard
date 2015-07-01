class TwitterClient
  def initialize(options = Rails.application.secrets)
    self.client = Twitter::REST::Client.new do |config|
      config.consumer_key        = options.twitter_consumer_key
      config.consumer_secret     = options.twitter_consumer_secret
      config.access_token        = options.twitter_access_token
      config.access_token_secret = options.twitter_access_token_secret
    end
  end

  def latest_mentions(count)
    client.mentions_timeline(count: count)
  end

  def getProfile(tweet)
    tweet.user.profile_image_uri('original')
  end

  def getURLs(tweets)
    extract_urls(tweets[0].full_text)
  end

  private

  attr_accessor :client
end
