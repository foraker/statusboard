module Pages
  module Components
    class WeatherComponent
      delegate :high_temp, :low_temp, :condition, :condition_temp,
        :current_temp, :icon, to: :todays_forecast

      def initialize(options = Rails.application.secrets)
        self.client = Weatherman::Client.new unit: 'f'
        self.options = options
      end

      def five_day_forecast
        Forecast.wrap(weather.forecasts[1..4])
      end

      private

      attr_accessor :client, :options

      def weather
        @weather ||= client.lookup_by_woeid options.weather_woeid
      end

      def todays_forecast
        @todays_forecast ||= TodaysForecast.new(weather.forecasts.first.merge(weather.condition))
      end

      class Forecast
        attr_accessor :response

        def self.wrap(responses)
          responses.map { |response| self.new(response) }
        end

        def initialize(response)
          self.response = response
        end

        def day_of_week
          response['day'].upcase
        end

        def forecast_icon
          icon
        end

        def condition_code
          response['code']
        end

        def high_temp
          response['high']
        end

        def low_temp
          response['low']
        end

        def icon
          Icon.from_code(condition_code)
        end
      end

      class TodaysForecast < Forecast
        def current_temp
          response['temp']
        end

        def condition
          response['text']
        end
      end

      class Icon
        def self.from_code(code)
          new(code).to_s
        end

        def initialize(code, config_path = Rails.root.join('config/weather_icons.yml'))
          self.code   = code
          self.config = YAML.load_file(config_path).map { |config| OpenStruct.new(config) }
        end

        def to_s
          configuration.icon
        end

        private

        attr_accessor :code, :config

        def configuration
          matching_configuration || default_configuration
        end

        def matching_configuration
          config.detect { |configuration| configuration.codes.include? code }
        end

        def default_configuration
          OpenStruct.new(icon: "volcano")
        end
      end
    end
  end
end
