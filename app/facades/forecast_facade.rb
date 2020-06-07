class ForecastFacade
  attr_reader :data

  def initialize(location)
    @location = location
    @data = load_forecast
  end

  def load_forecast
    location_data = Location.new(@location)
    weather_data = OpenWeatherService.new.weather_data(location_data.lat, location_data.long)
    forecast = Forecast.new(@location, weather_data)
  end
end
