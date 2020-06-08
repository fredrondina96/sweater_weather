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

    # cusine id
    response = Faraday.get('https://developers.zomato.com/api/v2.1/cuisines?') do |req|
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.long
      req.headers['user-key'] = ENV.fetch('ZOMATO_API_KEY')
    end
    food_ids = JSON.parse(response.body, symbolize_names: true)[:cuisines]

      food_id = food_ids.find do |food|
         food[:cuisine][:cuisine_name] == params[:search].capitalize
      end

    #get restauraunt
    response = Faraday.get('https://developers.zomato.com/api/v2.1/search') do |req|
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.long
      req.params['cuisines'] = food_id[:cuisine][:cuisine_id]
      req.headers['user-key'] = ENV.fetch('ZOMATO_API_KEY')
    end
    restaurant = JSON.parse(response.body, symbolize_names: true)[:restaurants].first
    # binding.pry
  end
end
