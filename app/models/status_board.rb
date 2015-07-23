class StatusBoard
  def components
    [
      twitter_component,
      github_component
    ]
  end

  def weather_component
    @weather_component ||= WeatherComponent.new
  end

  def github_component
    @github_component ||= Components::GithubComponent.new
  end

  private

  def twitter_component
    @twitter_component ||= Components::TwitterComponent.new
  end

  def photo_component
    @photo_component ||= PhotoComponent.new
  end

  def parser_component
    @parser_component ||= UrlParser.new
  end
end
