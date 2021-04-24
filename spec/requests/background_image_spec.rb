require 'rails_helper'

RSpec.describe 'Background Image for the City' do
  scenario 'Sad Path ~ With no parameter I receieve an error message' do
    get '/api/v1/backgrounds?location='
    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Sad Path ~ Integer gives an invalid request' do
    get '/api/v1/backgrounds?location=913084098-34'
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Happy Path ~ Can retrieve background image' do
    VCR.use_cassette('requests/background_image/happy_path_1',
    match_requests_on: %i[body]) do
      get '/api/v1/backgrounds?location=tampa,fl'
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end