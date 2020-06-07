class Location
  attr_reader :lat,
              :long

  def initialize(location)
    @location = load_location(location)
    @lat = @location[:lat]
    @long = @location[:lng]
  end

  private

  def load_location(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?') do |req|
      req.params['address'] = location
      req.params['key'] = ENV['GOOGLE_API_KEY']
    end
    coordinates = JSON.parse(response.body, symbolize_names: true)[:results].first[:geometry][:location]
  end
end
