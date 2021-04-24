class Api::V1::WeatherController < ApplicationController
  def get_forecast
    WeatherFacade.new(params[:location])
  end
end