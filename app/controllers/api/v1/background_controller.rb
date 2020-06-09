class Api::V1::BackgroundController < ApplicationController
  def show
    response = Faraday.get 'https://api.unsplash.com/search/photos?' do |req|
      req.params['query'] = params[:location]
      req.params['per_page'] = 1
      req.params['count'] = 1
      req.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
   image_url = JSON.parse(response.body, symbolize_names: true)[:results].first[:urls][:full]
   binding.pry
 end
end
