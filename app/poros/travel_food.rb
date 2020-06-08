class TravelFood
  attr_reader :id, :forecast, :travel_time, :restaurant, :end_location

 def initialize(end_location, travel_time, forecast, restaurant)
   @id = nil
   @end_location = end_location
   @travel_time = travel_time
   @forecast = forecast
   @restaurant = restaurant
 end
end
