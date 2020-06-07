class GoogleService
  def load_location_data(location)
      response = connection.get('/maps/api/geocode/json') do |req|
        req.params['address'] = location
      end
    JSON.parse(response.body, symbolize_names: true)[:results].first[:geometry][:location]
  end

  def connection
    Faraday.new(url: 'https://maps.googleapis.com') do |req|
      req.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end
end
