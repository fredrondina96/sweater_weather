class Api::V1::FoodieController < ApplicationController

  def show
    # travel time
    response = Faraday.get('https://maps.googleapis.com/maps/api/directions/json?') do |req|
      req.params['origin'] = params[:start]
      req.params['destination'] = params[:end]
      req.params['key'] = ENV['GOOGLE_API_KEY']
    end
    travel_time = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first[:duration][:text]
    # binding.pry

    coordinates = Location.new(params[:end])

    restaurant = Restaurant.new(coordinates, params[:search])
    
    forecast = ForecastFacade.new(params[:end])
    weather_summary = ("Temp is #{forecast.data.current_temp}, Forecast is #{forecast.data.current_description}")
    travel_food = TravelFood.new(params[:end], travel_time, weather_summary, restaurant)
    # binding.pry
    render json: TravelFoodSerializer.new(travel_food)
  end
end
