require 'rails_helper'

RSpec.describe 'Travel Food Request', type: :request do
  it 'should return travel time, weather, and food for city' do

    @time_now = Time.parse('2020-06-08 10:55:00 -0700')
    allow(Time).to receive(:now).and_return(@time_now)

    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    summary = JSON.parse(response.body)
    actual_data = summary['data']['attributes']

    expected = {
    "data": {
        "id": nil,
        "type": "travel_food",
        "attributes": {
            "end_location": "pueblo,co",
            "travel_time": "1 hour 48 mins",
            "forecast": "Temp is 76.32, Forecast is Clear",
            "restaurant": {
                "name": "Angelo's Pizza Parlor",
                "address": "105 E Riverwalk, Pueblo 81003"
                  }
                    }
                      }
                          }
    expect(actual_data["end_location"]).to eq(expected[:data][:attributes][:end_location])
    expect(actual_data["travel_time"]).to eq(expected[:data][:attributes][:travel_time])
    expect(actual_data["forecast"]).to eq(expected[:data][:attributes][:forecast])
    expect(actual_data["restaurant"]["address"]).to eq(expected[:data][:attributes][:restaurant][:address])
    expect(actual_data["restaurant"]["name"]).to eq(expected[:data][:attributes][:restaurant][:name])
  end
end
