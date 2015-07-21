module Importers
  class TwitterImporter
    def initialize(options = Rails.application.secrets)
      self.client = Twitter::REST::Client.new do |config|
        config.consumer_key        = options.twitter_consumer_key
        config.consumer_secret     = options.twitter_consumer_secret
        config.access_token        = options.twitter_access_token
        config.access_token_secret = options.twitter_access_token_secret
      end
    end

    def import
      tweets = latest_mentions(10)

      tweets.each do |tweet|
        TweetImporter.new(tweet).import
      end

    end

    private

    attr_accessor :client

    def latest_mentions(count)
      client.mentions_timeline(count: count)
    end

    class TweetImporter < Struct.new(:tweet)
      delegate :full_text, :created_at, :url, :user, to: :tweet

      def import
        Tweet.where(twitter_id: tweet.id).
          create_with(
            author:       author,
            tweet:        full_text,
            image_url:    profile_image,
            tweet_url:    url,
            published_at: created_at
          ).first_or_create
      end

      def author
        user.screen_name
      end

      def profile_image
        user.profile_image_uri('original')
      end
    end
  end
end
