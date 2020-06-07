class GoogleService
  def load_location_data(location)
      response = connection.get('/maps/api/geocode/json') do |faraday|
        faraday.params['address'] = location
      end
    JSON.parse(response.body, symbolize_names: true)[:results].first[:geometry][:location]
  end

  def connection
    Faraday.new(url: 'https://maps.googleapis.com') do |faraday|
      faraday.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end
end
