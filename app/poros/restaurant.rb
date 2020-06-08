class Restaurant
  attr_reader :name,
              :address

  def initialize(location)
    @data = load_data
    @name = @location[:lat]
    @address = @location[:lng]
  end

  private

  def load_location(location)
    GoogleService.new.load_location_data(location)
    # binding.pry
    # response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?') do |req|
    #   req.params['address'] = location
    #   req.params['key'] = ENV['GOOGLE_API_KEY']
    # end
    # coordinates = JSON.parse(response.body, symbolize_names: true)[:results].first[:geometry][:location]
  end
end
