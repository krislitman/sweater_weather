class Api::V1::WeatherController < ApplicationController
  def get_forecast
    WeatherFacade.new(params[:location])
    # coordinates = WeatherService.lat_and_long(params[:location])
    # require 'pry'; binding.pry
  end
end