require 'rails_helper'

RSpec.describe RoadTripWeather do
  it 'Can be created with attributes' do
    attributes = {
      :dt=>1619553600, 
      :temp=>80.83, 
      :feels_like=>79.7, 
      :pressure=>1013, 
      :humidity=>30, 
      :dew_point=>46.54, 
      :uvi=>4.08, 
      :clouds=>11, 
      :visibility=>10000, 
      :wind_speed=>12.82, 
      :wind_deg=>240, 
      :wind_gust=>22.37, 
      :weather=>
      [{:id=>801, 
        :main=>"Clouds", 
        :description=>"few clouds", 
        :icon=>"02d"}], 
      :pop=>0
    }
    expected = RoadTripWeather.new(attributes)

    expect(expected).to be_an_instance_of(RoadTripWeather)
    expect(expected.conditions).to eq('few clouds')
    expect(expected.icon).to eq('02d')
    expect(expected.temperature).to eq(80.83)
    expect(expected.time).to eq("04 00 PM")
  end
end