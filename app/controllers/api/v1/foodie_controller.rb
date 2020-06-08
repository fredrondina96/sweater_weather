class Api::V1::FoodieController < ApplicationController

  def show
    response = Faraday.get('https://maps.googleapis.com/maps/api/directions/json?') do |req|
      req.params['origin'] = params[:start]
      req.params['destination'] = params[:end]
      req.params['key'] = ENV['GOOGLE_API_KEY']
    end
    travel_time = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first[:duration][:text]
    binding.pry
  end
end
