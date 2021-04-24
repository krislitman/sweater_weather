require 'rails_helper'

RSpec.describe WeatherService do
  it 'Returns proper data from OpenWeatherMap' do
    VCR.use_cassette('weather_service_spec',
    match_requests_on: %i[body]) do
      facade = WeatherFacade.new('Tampa,FL')
      response = WeatherService.find_forecast(facade.lat_and_long)

      expect(response).to be_a(Hash)
      expect(response.keys).to include(:lat)
      expect(response.keys).to include(:lon)
    end
  end
end