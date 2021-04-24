class Api::V1::WeatherController < ApplicationController
  def get_forecast
    coordinates = WeatherService.lat_and_long(params[:location])

  #   conn = Faraday.new('http://www.mapquestapi.com')
  #   response = conn.get("geocoding/v1/address") do |req|
  #     req.params['location'] = params[:location]
  #     req.params['key'] = Figaro.env.key
  #   end
    
  # data = JSON.parse(response.body)

  require 'pry'; binding.pry
  end
end