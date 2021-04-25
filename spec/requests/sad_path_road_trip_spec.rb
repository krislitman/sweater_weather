require 'rails_helper'

RSpec.describe 'Sad Path Road Trip', type: :request do
  scenario 'When I give incorrect API key, I get a 401 error' do
    User.destroy_all
    User.create(
      email: "email@example.com",
      password: "password"
    )
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "123YO"
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
  end
end