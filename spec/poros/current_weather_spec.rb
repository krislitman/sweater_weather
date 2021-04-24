require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'Can be created with attributes' do
    VCR.use_cassette('poros/current_weather',
    match_requests_on: %i[body]) do

      facade = WeatherFacade.new('Pittsburgh,PA')
      current = facade.current_weather
      expected = JSON.parse(current.to_json, symbolize_names: true)

      expect(current).to be_an_instance_of(CurrentWeather)
      expect(expected.keys).to include(:datetime)
      expect(expected.keys).to include(:sunrise)
      expect(expected.keys).to include(:sunset)
      expect(expected.keys).to include(:temperature)
      expect(expected.keys).to include(:feels_like)
      expect(expected.keys).to include(:humidity)
      expect(expected.keys).to include(:uvi)
      expect(expected.keys).to include(:visibility)
      expect(expected.keys).to include(:conditions)
      expect(expected.keys).to include(:icon)

      expect(expected.keys).not_to include(:time)
      expect(expected.keys).not_to include(:max_temp)
      expect(expected.keys).not_to include(:min_temp)
      expect(expected.keys).not_to include(:date)
    end
  end
end