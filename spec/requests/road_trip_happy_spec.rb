require 'rails_helper'

RSpec.describe 'Happy Path Road Trip', type: :request do
  scenario 'When correct params are given, I receive roadtrip info' do
    VCR.use_cassette('requests/road_trip/happy_path_1',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(expected).to be_a(Hash)
      expect(expected[:data].keys).to include(:id)
      expect(expected[:data].keys).to include(:type)
      expect(expected[:data].keys).to include(:attributes)
      expect(expected[:data][:attributes].keys).to include(:start_city)
      expect(expected[:data][:attributes].keys).to include(:end_city)
      expect(expected[:data][:attributes].keys).to include(:travel_time)
      expect(expected[:data][:attributes].keys).to include(:weather_at_eta)
      expect(expected[:data][:attributes][:weather_at_eta].keys).to include(:temperature)
      expect(expected[:data][:attributes][:weather_at_eta].keys).to include(:conditions)
    end
  end
  scenario 'When correct params are given, I receive roadtrip info part two' do
    VCR.use_cassette('requests/road_trip/happy_path_2',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Tampa,FL",
        "destination": "Pittsburgh,PA",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('roadtrip')
    end
  end
  scenario 'When correct params are given, I receive roadtrip info part three' do
    VCR.use_cassette('requests/road_trip/happy_path_3',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Los Angeles,CA",
        "destination": "New York,NY",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('roadtrip')
    end
  end
  scenario 'When correct params are given, FINAL test' do
    VCR.use_cassette('requests/road_trip/happy_path_4',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      body = {
        "origin": "Washington,DC",
        "destination": "Miami,FL",
        "api_key": "#{user1.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json',
         'ACCEPT' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('roadtrip')
    end
  end
end