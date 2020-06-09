require 'rails_helper'

RSpec.describe 'Forecast Request', type: :request do
  it 'should return the forcast for a given city' do
    get '/api/v1/forecast?location=denver,co'
    expect(response).to be_successful
  end
end
