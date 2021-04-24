require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'Can be created with attributes' do
    VCR.use_cassette('poros/hourly_weather',
    match_requests_on: %i[body]) do

      facade = WeatherFacade.new('Atlanta,GA')
      current = facade.hourly_weather
      expected = JSON.parse(current.to_json, symbolize_names: true)

      expect(current[0]).to be_an_instance_of(HourlyWeather)
      expect(current.length).to eq(8)
      expect(expected[0].keys).to include(:time)
      expect(expected[0].keys).to include(:temperature)
      expect(expected[0].keys).to include(:conditions)
      expect(expected[0].keys).to include(:icon)

      expect(expected[0].keys).not_to include(:date)
      expect(expected[0].keys).not_to include(:sunrise)
      expect(expected[0].keys).not_to include(:sunset)
      expect(expected[0].keys).not_to include(:max_temp)
      expect(expected[0].keys).not_to include(:min_temp)
      expect(expected[0].keys).not_to include(:feels_like)
      expect(expected[0].keys).not_to include(:humidity)
      expect(expected[0].keys).not_to include(:uvi)
      expect(expected[0].keys).not_to include(:visibility)
      expect(expected[0].keys).not_to include(:datetime)
    end
  end
end