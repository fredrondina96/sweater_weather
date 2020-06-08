require 'rails_helper'

RSpec.describe 'Travel Food Request', type: :request do
  it 'should return travel time, weather, and food for city' do
    get "/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian"
    expect(response).to be_successful
  end
end
