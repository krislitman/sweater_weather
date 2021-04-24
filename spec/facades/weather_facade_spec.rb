require 'rails_helper'

RSpec.describe WeatherFacade do
  it "Can be created with a location" do
    VCR.use_cassette('weather_facade_create') do
      expected = WeatherFacade.new("Denver,CO")

      expect(expected).to be_an_instance_of(WeatherFacade)
      expect(expected.location).to eq('Denver,CO')
      expect(expected.lat_and_long).to be_an_instance_of(MapQuest)
      expect(expected.lat_and_long.lat).to eq(39.738453)
      expect(expected.lat_and_long.lng).to eq(-104.984853)
    end
  end
  it "Can find current_weather" do
    VCR.use_cassette('current_weather') do
      facade = WeatherFacade.new("Denver,CO")
      weather = facade.current_weather

      expect(weather).to be_an_instance_of(CurrentWeather)
    end
  end
  it "Can find daily_weather" do
    VCR.use_cassette('current_weather') do
      facade = WeatherFacade.new("Denver,CO")
      weather = facade.current_weather

      expect(weather).to be_an_instance_of(CurrentWeather)
    end
  end
end