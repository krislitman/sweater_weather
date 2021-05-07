require 'rails_helper'

RSpec.describe 'Add Unit Query Parameter', type: :request do
  scenario 'Can change units to ~metric~ or default-imperial' do
    VCR.use_cassette('requests/extensions/add_query_parameter',
    match_requests_on: %i[body]) do
      params = {
        location: 'denver,co',
        units: 'imperial'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)

      # expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(data[:data][:attributes][:current_weather].keys).to include(:temperature)
    end
  end
  scenario 'Metric works as well' do
    VCR.use_cassette('requests/extensions/add_query_parameter_metric',
    match_requests_on: %i[body]) do
      params = {
        location: 'denver,co',
        units: 'metric'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)

      # expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(data[:data][:attributes][:current_weather].keys).to include(:temperature)
    end
  end
  scenario 'Sad Path ~ integer returns nil' do
    VCR.use_cassette('requests/extensions/add_query_parameter_metric_sad',
    match_requests_on: %i[body]) do
      params = {
        location: 'denver,co',
        units: '12345'
      }
      get api_v1_forecast_path, params: params
      data = JSON.parse(response.body, symbolize_names: true)
      
      # expect(response).to be_successful
      expect(data[:data][:attributes][:current_weather]).to be(nil)
    end
  end
end