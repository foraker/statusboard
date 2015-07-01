class WeatherClient
  def initialize
    self.client = Weatherman::Client.new unit: 'f'
  end

  def getWeather
    client.lookup_by_woeid 2367231
  end

  attr_accessor :client
end
