require 'rails_helper'

RSpec.describe 'Background Image API', type: :request do
  it 'should return an image when provided with a city', :vcr do
    location = 'Naples, FL'

    expected = {
                data: {
                  :id=>nil,
                  :type=>"background",
                  :attributes=>{
                    :id=>nil,
                    :url=>"https://images.unsplash.com/photo-1541364449983-738946b792ac?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE0MDg4OX0"
                    }
                  }
      }

    get "/api/v1/backgrounds?location=#{location}"

    actual = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(actual).to eq(expected)
  end
end
