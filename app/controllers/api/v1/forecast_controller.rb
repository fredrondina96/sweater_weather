class Api::V1::ForecastController < ApplicationController
  def show
    location_data = Location.new(params[:location])
    weather_data = OpenWeatherService.new.weather_data(location_data.lat, location_data.long)
    forecast = Forecast.new(params[:location], weather_data)
    render json: ForecastSerializer.new(forecast)
  end
end
