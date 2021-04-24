require 'rails_helper'

RSpec.describe WeatherService do
  it 'Returns proper data from MapQuest' do
    VCR.use_cassette('weather_service_spec') do
      response = WeatherService.lat_and_long('Denver,CO')

      expect(response).to be_a(Hash)
      expect(response[:results][0][:providedLocation][:location]).to eq('Denver,CO')
      expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.738453)
      expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.984853)
    end
  end
end