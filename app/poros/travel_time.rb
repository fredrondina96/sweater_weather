class TravelTime

  attr_reader :time

  def initialize(origin, destination)
    @time = load_travel_time(origin, destination)
  end

  def load_travel_time(origin, destination)
    response = Faraday.get('https://maps.googleapis.com/maps/api/directions/json?') do |req|
      req.params['origin'] = origin
      req.params['destination'] = destination
      req.params['key'] = ENV['GOOGLE_API_KEY']
    end
    travel_time = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first[:duration][:text]
  end

end
