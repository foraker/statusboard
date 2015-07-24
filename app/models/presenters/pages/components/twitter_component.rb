module Presenters
  module Pages
    module Components
      class TwitterComponent < Base
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
end
