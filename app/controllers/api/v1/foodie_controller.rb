class Api::V1::FoodieController < ApplicationController

  def show
    travel_time = TravelTime.new(params[:start], params[:end])
    restaurant = Restaurant.new(Location.new(params[:end]), params[:search])
    forecast = ForecastFacade.new(params[:end]).quick_forecast
    travel_food = TravelFood.new(params[:end], travel_time.time, forecast, restaurant)
    render json: TravelFoodSerializer.new(travel_food)
  end
end
