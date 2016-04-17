module Pages
  module Components
    class WeatherComponent
      delegate :condition, :high_temp, :low_temp, :current_temp,
        :forecast_icon, to: :todays_forecast

      def initialize(options = Rails.application.secrets)
        self.options = options
        self.weather = ForecastIO.forecast(latitude, longitude)
      end

      def five_day_forecast
        Forecast.wrap(daily_weather[1..4])
      end

      private

      attr_accessor :weather, :options

      def latitude
        options.weather['weather_lat']
      end

      def longitude
        options.weather['weather_long']
      end

      def daily_weather
        @daily_weather ||= weather[:daily][:data]
      end

      def todays_forecast
        @todays_forecast ||= TodaysForecast.new(
          daily_weather.first.merge(current_attrs)
        )
      end

      def current_attrs
        current_weather.slice(
          :temperature,
          :summary,
          :icon
        )
      end

      def current_weather
        weather[:currently]
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
          date.strftime("%a").upcase
        end

        def forecast_icon
          response[:icon]
        end

        def high_temp
          response[:temperatureMax].round
        end

        def low_temp
          response[:temperatureMin].round
        end

        private

        def date
          DateTime.strptime(response[:time].to_s,'%s')
        end
      end

      class TodaysForecast < Forecast
        def current_temp
          response[:temperature].round
        end

        def condition
          response[:summary]
        end
      end
    end
  end
end
