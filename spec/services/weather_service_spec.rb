require 'rails_helper'

RSpec.describe WeatherService do
  it 'Returns proper data from OpenWeatherMap' do
    VCR.use_cassette('services/weather_service_spec',
    match_requests_on: %i[body]) do
      attributes = MapService.lat_and_long('Tampa,FL')
      lat_and_long = MapQuest.new(attributes)
      response = WeatherService.find_forecast(lat_and_long, 'imperial')

      expect(response).to be_a(Hash)
      expect(response.keys).to include(:lat)
      expect(response.keys).to include(:lon)
    end
  end
  it 'Sad Path ~ Does not work with wrong params' do
    VCR.use_cassette('services/weather_service_spec_sad_1',
    match_requests_on: %i[body]) do
      response = WeatherService.find_forecast(12345, 'imperial')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Does not work with wrong params 2' do
    VCR.use_cassette('services/weather_service_spec_sad_2',
    match_requests_on: %i[body]) do
      response = WeatherService.find_forecast("NOWHEREWHATEVER", 'imperial')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ No params 1' do
    VCR.use_cassette('services/weather_service_spec_sad_3',
    match_requests_on: %i[body]) do
      response = WeatherService.find_forecast("", "")
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Does not work with wrong params 3' do
    VCR.use_cassette('services/weather_service_spec_sad_4',
    match_requests_on: %i[body]) do
      response = WeatherService.road_trip("NOWHEREWHATEVER", 'imperial')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Does not work with integers' do
    VCR.use_cassette('services/weather_service_spec_sad_5',
    match_requests_on: %i[body]) do
      response = WeatherService.road_trip("12345", '12345')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Road trip empty wont work but good try' do
    VCR.use_cassette('services/weather_service_spec_sad_6',
    match_requests_on: %i[body]) do
      response = WeatherService.road_trip("", '')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Weather data cant get made without data' do
    VCR.use_cassette('services/weather_service_spec_sad_7',
    match_requests_on: %i[body]) do
      response = WeatherService.weather_data("", '')
  
      expect(response).to be(nil)
    end
  end
  it 'Sad Path ~ Weather data cant get made without data 2' do
    VCR.use_cassette('services/weather_service_spec_sad_8',
    match_requests_on: %i[body]) do
      response = WeatherService.weather_data("WRONG", "UNACCEPTABLE")
  
      expect(response).to be(nil)
    end
  end
end