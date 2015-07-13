class WeatherComponent
  def initialize
    self.client = Weatherman::Client.new unit: 'f'
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

  attr_accessor :client

  def weather
    @weather ||= client.lookup_by_woeid 2367231
  end
end
