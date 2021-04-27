require 'rails_helper'

RSpec.describe 'Background Image for the City', type: :request do
  scenario 'Sad Path ~ With no parameter I receieve an error message' do
    params = {
      location: ''
    }
    get api_v1_backgrounds_path, params: params
    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Sad Path ~ Integer gives an invalid request' do
    params = {
      location: '913084098-34'
    }
    get api_v1_backgrounds_path, params: params
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Sad Path ~ Weird string messes things up' do
    params = {
      location: 'HELLOWORLD FOO BAR'
    }
    get api_v1_backgrounds_path, params: params
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
  scenario 'Happy Path ~ Can retrieve background image' do
    VCR.use_cassette('requests/background_image/happy_path_1',
    match_requests_on: %i[body]) do
      params = {
        location: 'tampa,fl'
      }
      get api_v1_backgrounds_path, params: params
      
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes].keys).to include(:image)
      expect(expected[:data][:attributes][:image].keys).to include(:location)
      expect(expected[:data][:attributes][:image].keys).to include(:image_url)
      expect(expected[:data][:attributes][:image].keys).to include(:credit)
      expect(expected[:data][:attributes][:image][:credit].keys).to include(:source)
      expect(expected[:data][:attributes][:image][:credit].keys).to include(:owner)
    end
  end
  scenario 'Happy Path ~ Can retrieve another background image' do
    VCR.use_cassette('requests/background_image/happy_path_2',
    match_requests_on: %i[body]) do
      params = {
        location: 'pittsburgh,pa'
      }
      get api_v1_backgrounds_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes].keys).to include(:image)
    end
  end
  scenario 'Happy Path ~ And yet I can retrieve another background image' do
    VCR.use_cassette('requests/background_image/happy_path_3',
    match_requests_on: %i[body]) do
      params = {
        location: 'denver,co'
      }
      get api_v1_backgrounds_path, params: params
      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(expected[:data][:attributes].keys).to include(:image)
    end
  end
end