require 'rails_helper'

RSpec.describe 'Sad Path Road Trip', type: :request do
  scenario 'When I give no API key, I get a 401 error' do
    User.destroy_all
    User.create(
      email: "email@example.com",
      password: "password"
    )
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": ""
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(401)
    expect(expected.keys).to include(:message)
    expect(expected[:message].keys).to include(:unauthorized)
    expect(expected[:message][:unauthorized]).to include('Incorrect Key')
  end
  scenario 'When I give an incorrect API key, I get a 401 error' do
    User.destroy_all
    User.create(
      email: "email@example.com",
      password: "password"
    )
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "123ABC"
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
      
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(401)
    expect(expected[:message][:unauthorized]).to include('Incorrect Key')
  end
end