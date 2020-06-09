RSpec.describe 'User Login Request' do
  it 'Returns user email and api key, with 200 response' do
    post "/api/v1/users", params: {
        email: 'newuser@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

    post '/api/v1/sessions', params: {email: "newuser@example.com",
                                      password: 'password'}


    expect(response).to be_successful
    expect(response.status).to eq(200)
    json = JSON.parse(response.body, symbolize_names: true)
    expect("newuser@example.com").to eq(json[:data][:attributes][:email])
    expect(json[:data][:type]).to eq('users')
    expect(json[:data][:attributes].keys.include?(:email)).to eq(true)
    expect(json[:data][:attributes].keys.include?(:api_key)).to eq(true)
  end

  it '400 error is returned when invalid credentials recieved' do
    post "/api/v1/users", params: {
        email: 'newuser@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

    post '/api/v1/sessions', params: {email: "asdf@asdf.com",
                                      password: 'asdf'}

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq('Invalid Credentials')
  end
end
