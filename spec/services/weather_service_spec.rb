require 'rails_helper'

RSpec.describe WeatherService do
  it 'Returns proper data from OpenWeatherMap' do
    VCR.use_cassette('services/weather_service_spec',
    match_requests_on: %i[body]) do
      facade = WeatherFacade.new('Tampa,FL')
      response = WeatherService.find_forecast(facade.lat_and_long, 'imperial')

      expect(response).to be_a(Hash)
      expect(response.keys).to include(:lat)
      expect(response.keys).to include(:lon)
    end
  end
  it '#road_trip' do
    VCR.use_cassette('services/weather_service_road_trip',
      match_requests_on: %i[body]) do
        User.destroy_all
        user1 = User.create(
        email: "example@test.com",
        password: "test123"
      )
      params = {
        :origin=>"Denver,CO",
        :destination=>"Pueblo,CO", 
        :api_key=>"#{user1.api_key}"
      }
      facade = RoadTripFacade.new(params)
      expected = facade.find_weather
      
      expect(expected).to be_a(Hash)
      expect(expected.keys).to include(:temperature)
      expect(expected.keys).to include(:conditions)
    end
  end
  it 'Sad Path ~ Does not work with wrong params' do
    VCR.use_cassette('services/weather_service_spec_sad_1',
    match_requests_on: %i[body]) do
      facade = WeatherFacade.new('Tampa,FL')
      response = WeatherService.find_forecast(12345, 'imperial')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Does not work with wrong params 2' do
    VCR.use_cassette('services/weather_service_spec_sad_2',
    match_requests_on: %i[body]) do
      facade = WeatherFacade.new('Tampa,FL')
      response = WeatherService.find_forecast("NOWHEREWHATEVER", 'imperial')
  
      expect(response).to be(nil)
    end
  end
end