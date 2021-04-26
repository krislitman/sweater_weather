require 'rails_helper'

RSpec.describe RoadTripFacade do
  it "It can return a road trip with attributes" do
    VCR.use_cassette('facades/road_trip/create',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      params = {
        :origin=>"Denver,CO", 
        :destination=>"Pueblo,CO", 
        :api_key=>"BQ1xKq7T9n2vmSvKULGoeFD1"
      }
      facade = RoadTripFacade.new(params)
      expected = JSON.parse(facade.to_json, symbolize_names: true)

      expect(facade).to be_an_instance_of(RoadTripFacade)
      expect(expected.keys).to include(:end_city)
      expect(expected.keys).to include(:start_city)
      expect(expected.keys).to include(:travel_time)
      expect(expected.keys).to include(:weather_at_eta)
      expect(expected[:weather_at_eta]).to be_a(Hash)
      expect(expected[:weather_at_eta].keys).to include(:temperature)
      expect(expected[:weather_at_eta].keys).to include(:conditions)
    end
  end
  it "#destination_coordinates" do
    VCR.use_cassette('facades/road_trip/destination_coordinates',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      params = {
        :origin=>"Denver,CO", 
        :destination=>"Pueblo,CO", 
        :api_key=>"BQ1xKq7T9n2vmSvKULGoeFD1"
      }
      facade = RoadTripFacade.new(params)
      
      expect(facade.destination_coordinates).to be_an_instance_of(MapQuest)
    end
  end
  it "#find_weather" do
    VCR.use_cassette('facades/road_trip/find_weather',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      params = {
        :origin=>"Denver,CO", 
        :destination=>"Pueblo,CO", 
        :api_key=>"BQ1xKq7T9n2vmSvKULGoeFD1"
      }
      facade = RoadTripFacade.new(params)
      expected = facade.find_weather
      
      expect(expected.keys).to include(:temperature)
      expect(expected.keys).to include(:conditions)
    end
  end
  it "#find_arrival_time" do
    VCR.use_cassette('facades/road_trip/find_arrival_time',
    match_requests_on: %i[body]) do
      User.destroy_all
      user1 = User.create(
        email: "email@example.com",
        password: "password"
      )
      params = {
        :origin=>"Denver,CO", 
        :destination=>"Pueblo,CO", 
        :api_key=>"BQ1xKq7T9n2vmSvKULGoeFD1"
      }
      facade = RoadTripFacade.new(params)
      expected = facade.find_arrival_time
      
      expect(expected).to eq('current_weather')
    end
  end
end