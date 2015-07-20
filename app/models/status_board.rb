class StatusBoard
  def components
    [
      twitter_component,
      photo_component,
      github_component,
      weather_component
    ]
  end

  def weather_component
    @weather_component ||= WeatherComponent.new
  end

  def github_component
    @github_component ||= GithubComponent.new
  end

  private

  def twitter_component
    @twitter_component ||= TwitterComponent.new
  end

  def photo_component
    @photo_component ||= PhotoComponent.new
  end

  def parser_component
    @parser_component ||= UrlParser.new
  end
end
