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

      def five_day_forecast
        weather.forecasts[1..4]
      end

      def icon(code = condition_code)
        Icon.from_code(code)
      end

      private

      attr_accessor :client, :options

      def weather
        @weather ||= client.lookup_by_woeid options.weather_woeid
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
