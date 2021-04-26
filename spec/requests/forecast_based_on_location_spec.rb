require 'rails_helper'

RSpec.describe 'Retrieve weather for a city', type: :request do
  scenario 'Happy Path ~ It can take in location and get forecast' do
    VCR.use_cassette('requests/forecast/happy_path_1',
    match_requests_on: %i[body]) do
      params = {
        location: 'denver,co'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(data).to be_a(Hash)
      expect(data[:data][:attributes]).to have_key(:current_weather)
      expect(data[:data][:attributes]).to have_key(:daily_weather)
      expect(data[:data][:attributes]).to have_key(:hourly_weather)
    end
  end
  scenario 'Happy Path ~ It can take in another location and get forecast' do
    VCR.use_cassette('requests/forecast/happy_path_2',
    match_requests_on: %i[body]) do
      params = {
        location: 'tampa,fl'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(data).to be_a(Hash)
      expect(data[:data][:attributes]).to have_key(:current_weather)
      expect(data[:data][:attributes]).to have_key(:daily_weather)
      expect(data[:data][:attributes]).to have_key(:hourly_weather)
    end
  end
  scenario 'Happy Path ~ It can take in yet another location and get forecast' do
    VCR.use_cassette('requests/forecast/happy_path_3',
      match_requests_on: %i[body]) do
      params = {
        location: 'portland,or'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(data).to be_a(Hash)
      expect(data[:data][:attributes]).to have_key(:current_weather)
      expect(data[:data][:attributes]).to have_key(:daily_weather)
      expect(data[:data][:attributes]).to have_key(:hourly_weather)
    end
  end
  scenario 'Sad Path ~ No parameters is a bad time' do
    params = {
      location: ''
    }
    get api_v1_forecast_path, params: params
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Sad Path ~ Integer doesnt work' do
    params = {
      location: '123456789000'
    }
    get api_v1_forecast_path, params: params
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
end