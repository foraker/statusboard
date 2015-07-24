module Pages
  class HeaderPage < StatusBoardPage
    def github_component
      @github_component ||= Components::GithubComponent.new
    end

    def weather_component
      @weather_component ||= Components::WeatherComponent.new
    end
  end
end
