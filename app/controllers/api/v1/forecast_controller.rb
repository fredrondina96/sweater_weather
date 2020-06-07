class Api::V1::ForecastController < ApplicationController
  def show
    location_data = Location.new(params[:location])
    binding.pry
  end
end
