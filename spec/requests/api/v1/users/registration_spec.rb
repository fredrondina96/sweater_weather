require 'rails_helper'

RSpec.describe 'User API Path', type: :request do
  it 'Can register a new user, and provide api key' do
    post "/api/v1/users", params: {
        email: 'newuser@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    user = User.last
    expect(response).to be_successful
    expect(user.api_key).to be_truthy
    expect(user.password_digest).to be_truthy
  end

  it 'will not register if user doesnt meet the requirments' do
    post "/api/v1/users", params: {
        email: 'newuser@example.com',
        password: 'password',
        password_confirmation: 'password1'
      }

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:errors]).to eq("Password confirmation doesn't match Password")
  end
end
