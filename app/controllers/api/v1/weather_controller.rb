class Api::V1::WeatherController < ApplicationController
  def get_forecast
    data = WeatherFacade.new(params[:location])
    render json: ForecastSerializer.new(data)
  end
end