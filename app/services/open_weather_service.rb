class OpenWeatherService
  def weather_data(lat, long)
    response = connection.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      req.params['lon'] = long
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def connection
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['WEATHER_SERVICE_KEY']
    end
  end
end
