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
    GoogleService.new.load_location_data(location)
  end
end
