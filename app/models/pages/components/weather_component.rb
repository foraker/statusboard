module Pages
  module Components
    class WeatherComponent
      def initialize(options = Rails.application.secrets)
        self.client = Weatherman::Client.new unit: 'f'
        self.options = options
      end

      def condition
        weather.condition['text']
      end

      def condition_code
        weather.condition['code']
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

      def image
        case condition_code
          when 0, 1, 2
            "tornado"
          when 3, 4
            "storm-showers"
          when 5, 6, 7, 8
            "snow-wind"
          when 9, 10, 11, 12
            "showers"
          when 13, 14, 15, 16
            "snowflake-cold"
          when 17, 18, 19
            "hail"
          when 20, 21, 22
            "fog"
          when 23, 24
            "strong-wind"
          when 25
            "thermometer-exterior"
          when 26, 27, 28, 29, 30
            "cloudy"
          when 31
            "night-clear"
          when 32, 33, 34
            "day-sunny"
          when 35
            "rain-mix"
          when 36
            "thermometer"
          when 37, 38, 39
            "thunderstorm"
          when 40
            "raindrops"
          when 41, 42, 43
            "snow"
          when 44
            "cloud"
          when 45, 46, 47
            "storm-showers"
          else
            "volcano"
        end
      end

      private

      attr_accessor :client, :options

      def weather
        @weather ||= client.lookup_by_woeid options.weather_woeid
      end
    end
  end
end
