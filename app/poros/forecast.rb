class Forecast
  attr_reader :location,
              :current_temp,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :sunrise,
              :sunset,
              :id,
              :current_description,
              :hourly_forecast,
              :daily_forecast

  def initialize(location, weather)
    @weather = weather
    @id = nil
    @location = location
    @current_temp = get_current_temp
    @feels_like = get_current_feels_like
    @humidity = get_current_humidity
    @visibility = get_current_visibility
    @uv_index = get_current_uv_index
    @sunrise = get_sunrise
    @sunset = get_sunset
    @current_description = get_current_description
    @hourly_forecast = get_hourly_forecast
    @daily_forecast = get_daily_forecast
    end

  private

  def get_current_temp
    @weather[:current][:temp]
  end

  def get_current_feels_like
    @weather[:current][:feels_like]
  end

  def get_current_humidity
    @weather[:current][:humidity]
  end

  def get_current_visibility
    # not currently loading for denver, should be here according to docs
    @weather[:current][:visibility]
  end

  def get_current_uv_index
    @weather[:current][:uvi]
  end

  def get_sunrise
    @weather[:current][:sunrise]
  end

  def get_sunset
    @weather[:current][:sunset]
  end

  def get_current_description
    @weather[:current][:weather].first[:main]
  end

  def get_hourly_forecast
    @weather[:hourly].inject(Hash.new({})) do |hourly, weather|
      hourly[weather[:dt]] = {
        temp: weather[:temp],
        weather: weather[:weather]
      }
      hourly
    end
  end

  def get_daily_forecast
    @weather[:daily].inject(Hash.new({})) do |daily, weather|
      daily[weather[:dt]] = {
        max_temp: weather[:temp][:max],
        min_temp: weather[:temp][:min],
        weather: weather[:weather],
        rain: weather[:rain]
      }
      daily
    end
  end
end
