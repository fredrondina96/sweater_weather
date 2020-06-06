class Api::V1::ForecastController < ApplicationController
  def show
      response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?') do |req|
        req.params['address'] = params[:location]
        req.params['key'] = ENV['GOOGLE_API_KEY']
      end
    coordinates = JSON.parse(response.body, symbolize_names: true)[:results].first[:geometry][:location]
    binding.pry
  end
end
