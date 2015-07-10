module Presenters
  class TwitterComponent < StatusBoardComponent
    def latest_tweets
      @tweets ||= Tweet.wrap(latest_mentions(15))
    end

    private

    class Tweet < SimpleDelegator
      def self.wrap(tweets)
        tweets.map { |tweet| new(tweet) }
      end

      def text
        UrlParser.new.auto_link_urls(full_text)
      end
    end
  end
end
