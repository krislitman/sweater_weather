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
    end
  end
end