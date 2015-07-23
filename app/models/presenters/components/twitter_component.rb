module Presenters
  module Components
    class TwitterComponent < StatusBoardComponent
      def tweets
        @tweets ||= Tweet.wrap(super)
      end

      private

      class Tweet < SimpleDelegator
        def self.wrap(tweets)
          tweets.map { |tweet| new(tweet) }
        end

        def text
          UrlParser.new.auto_link_urls(tweet)
        end
      end
    end
  end
end
