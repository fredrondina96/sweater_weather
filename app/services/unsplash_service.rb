class UnsplashService
  def load_image_url(location)
    response = Faraday.get 'https://api.unsplash.com/search/photos?' do |req|
      req.params['query'] = location
      req.params['per_page'] = 1
      req.params['count'] = 1
      req.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:results].first[:urls][:full]
  end
end
