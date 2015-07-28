module Pages
  module Components
    class WeatherComponent
      def initialize(options = Rails.application.secrets)
        self.client = Weatherman::Client.new unit: 'f'
        self.options = options
      end

      def image
        weather.description_image.attributes['src'].value
      end

      def condition
        weather.condition['text']
      end

      def current_temp
        weather.condition['temp']
      end

      def high_temp
        weather.forecasts.first['high']
      end

      def low_temp
        weather.forecasts.first['low']
      end

      private

      attr_accessor :client, :options

      def weather
        @weather ||= client.lookup_by_woeid options.weather_woeid
      end
    end
  end
end
