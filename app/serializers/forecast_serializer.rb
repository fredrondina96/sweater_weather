class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :current_temp, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunset, :current_description, :hourly_forecast, :daily_forecast
end
