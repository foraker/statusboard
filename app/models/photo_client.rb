class PhotoClient
  def initialize(options = Rails.application.secrets)
    self.client = Twitter::REST::Client.new do |config|
      config.consumer_key        = options.photo_consumer_key
      config.consumer_secret     = options.photo_consumer_secret
      config.access_token        = options.photo_access_token
      config.access_token_secret = options.photo_access_token_secret
    end
  end

  def latest_mentions(count)
    client.mentions_timeline(count: count)
  end

  def getProfile(tweet)
    tweet.user.profile_image_uri('original')
  end

  def getURL
    tweets = client.mentions_timeline(count: 1)
    extract_urls(tweets[0].full_text)[0]
  end

  private

  attr_accessor :client
end
