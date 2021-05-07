require 'rails_helper'  

RSpec.describe 'Destination City Forecast And Salary' do
  scenario 'Happy Path ~ Teleport API finds tech salary for destination city' do
    VCR.use_cassette('requests/job_salaries_1',
    match_requests_on: %i[body]) do
      params = {
        destination: 'chicago'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data]).to be_a(Hash)
      expect(expected[:data].keys).to include(:id)
      expect(expected[:data].keys).to include(:type)
      expect(expected[:data].keys).to include(:attributes)
      expect(expected[:data][:id]).to eq('null')
      expect(expected[:data][:type]).to eq('salaries')
      expect(expected[:data][:attributes].keys).to include(:destination)
      expect(expected[:data][:attributes].keys).to include(:forecast)
      expect(expected[:data][:attributes].keys).to include(:salaries)
      expect(expected[:data][:attributes][:forecast].keys).to include(:summary)
      expect(expected[:data][:attributes][:forecast].keys).to include(:temperature)
      expect(expected[:data][:attributes][:salaries]).to be_an(Array)
      expect(expected[:data][:attributes][:salaries][0].keys).to include(:title)
      expect(expected[:data][:attributes][:salaries][0].keys).to include(:min)
      expect(expected[:data][:attributes][:salaries][0].keys).to include(:max)
    end
  end
  scenario 'Happy Path ~ API call works for another city' do
    VCR.use_cassette('requests/job_salaries_2',
    match_requests_on: %i[body]) do
      params = {
        destination: 'denver'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes][:destination]).to eq('denver')
    end
  end
  scenario 'Happy Path ~ API call works for yet another city' do
    VCR.use_cassette('requests/job_salaries_3',
    match_requests_on: %i[body]) do
      params = {
        destination: 'pittsburgh'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes][:destination]).to eq('pittsburgh')
    end
  end
  scenario 'Happy Path ~ API call works for another major city' do
    VCR.use_cassette('requests/job_salaries_4',
    match_requests_on: %i[body]) do
      params = {
        destination: 'miami'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes][:destination]).to eq('miami')
    end
  end
  scenario 'Happy Path ~ API call works for one more major city' do
    VCR.use_cassette('requests/job_salaries_5',
    match_requests_on: %i[body]) do
      params = {
        destination: 'houston'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)   
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes][:destination]).to eq('houston')
    end
  end
  scenario 'Sad Path ~ Does not work without parameters' do
    VCR.use_cassette('requests/job_salaries_6',
    match_requests_on: %i[body]) do
      params = {
        destination: ''
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(expected[:message][:invalid_request]).to eq("Your parameters are bad and you should feel bad")
    end
  end
  scenario 'Sad Path ~ Does not work with a number' do
    VCR.use_cassette('requests/job_salaries_7',
    match_requests_on: %i[body]) do
      params = {
        destination: '987654321'
      }
      get api_v1_salaries_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(expected[:message][:invalid_request]).to eq("Your parameters are bad and you should feel bad")
    end
  end
end