class StatusBoard
  def initialize

  end

  def twitter_client
    @twitter_client ||= TwitterClient.new
  end

  def github_client
    @github_client ||= GithubClient.new
  end

  def weather_client
    @weather_client ||= WeatherClient.new
  end

  def parser_client
    @parser_client ||= UrlParser.new
  end

  def tweets
    @tweets ||= twitter_client.latest_mentions(15)
  end

  def profile(tweet)
    twitter_client.getProfile(tweet)
  end

  def parsed_url(tweet)
    #parser_client.extract_urls(tweet)
    parser_client.auto_link_urls(tweet)
  end

  def pull_requests
    github_client.pull_requests
  end

  def weather
    @weather ||= weather_client.getWeather
  end

  def photo_url
    parser_client.extract_urls(tweets[0].full_text)[0]

  end

  #this will need to be updated to check if there's actually an image
  def has_image_url?
    !photo_url.empty?
  end

  def weather_image
    weather.description_image.attributes['src'].value
  end

  def weather_condition
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
end
