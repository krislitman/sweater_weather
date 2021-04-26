class Api::V1::WeatherController < ApplicationController
  def forecast
    data = WeatherFacade.new(params[:location], params[:units])
    render json: ForecastSerializer.new(data)
  rescue StandardError
    invalid_request
  end
end
