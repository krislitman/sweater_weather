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
  scenario 'When I ask to go over seas its impossible' do
    VCR.use_cassette('requests/road_trip/sad_path_1',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "New York,NY",
        "destination": "London,UK",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('roadtrip')
      expect(expected[:data][:attributes][:weather_at_eta][:temperature]).to eq([])
      expect(expected[:data][:attributes][:weather_at_eta][:conditions]).to eq('impossible')
    end
  end
  scenario 'When I ask to go over seas its impossible part 2' do
    VCR.use_cassette('requests/road_trip/sad_path_2',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Dallas,TX",
        "destination": "Tokyo,JP",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(expected[:data][:attributes][:weather_at_eta][:temperature]).to eq([])
      expect(expected[:data][:attributes][:weather_at_eta][:conditions]).to eq('impossible')
    end
  end
  scenario 'When I ask to go over seas its impossible trilogy' do
    VCR.use_cassette('requests/road_trip/sad_path_3',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Pittsburgh,PA",
        "destination": "Hong Kong,CH",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(expected[:data][:attributes][:weather_at_eta][:temperature]).to eq([])
      expect(expected[:data][:attributes][:weather_at_eta][:conditions]).to eq('impossible')
    end
  end
  scenario 'When I try to go to the same place it wont work' do
    VCR.use_cassette('requests/road_trip/sad_path_4',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Pittsburgh,PA",
        "destination": "Pittsburgh,PA",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(202)
      expect(expected[:data][:attributes][:travel_time]).to eq('00:00:00')
    end
  end
end