module Pages
  module Components
    class PhotoComponent
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

      def url
        UrlParser.first_url(latest_mentions(1).first.full_text)
      end

      private

      attr_accessor :client
    end
  end
end
