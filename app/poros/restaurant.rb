class Restaurant
  attr_reader :name,
              :address

  def initialize(coordinates, cuisine)
    @name = load_data(coordinates, cuisine)[:restaurant][:name]
    @address = load_data(coordinates, cuisine)[:restaurant][:location][:address]
  end

  private

  def load_data(coordinates, cuisine)
    # cusine id
    response = Faraday.get('https://developers.zomato.com/api/v2.1/cuisines?') do |req|
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.long
      req.headers['user-key'] = ENV.fetch('ZOMATO_API_KEY')
    end
    food_ids = JSON.parse(response.body, symbolize_names: true)[:cuisines]

      food_id = food_ids.find do |food|
         food[:cuisine][:cuisine_name] == cuisine.capitalize
      end

    #get restauraunt
    response = Faraday.get('https://developers.zomato.com/api/v2.1/search') do |req|
      req.params['lat'] = coordinates.lat
      req.params['lon'] = coordinates.long
      req.params['cuisines'] = food_id[:cuisine][:cuisine_id]
      req.headers['user-key'] = ENV.fetch('ZOMATO_API_KEY')
    end
    restaurant = JSON.parse(response.body, symbolize_names: true)[:restaurants].first

  end
end
