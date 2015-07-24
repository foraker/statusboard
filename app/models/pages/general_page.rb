module Pages
  class GeneralPage < StatusBoardPage
    def twitter_component
      @twitter_component ||= Components::TwitterComponent.new
    end

    def weather_component
      @weather_component ||= Components::WeatherComponent.new
    end
  end
end
