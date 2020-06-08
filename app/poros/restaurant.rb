class Restaurant
  attr_reader :name,
              :address

  def initialize(coordinates, cuisine)
    @name = ZomatoService.new.load_data(coordinates, cuisine)[:restaurant][:name]
    @address = ZomatoService.new.load_data(coordinates, cuisine)[:restaurant][:location][:address]
  end
end
