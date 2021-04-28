class Api::V1::WeatherController < ApplicationController
  def forecast
    params[:units] = 'imperial' if !params[:units].present?
    data = WeatherFacade.new(params[:location], params[:units])
    render json: ForecastSerializer.new(data)
  rescue StandardError
    invalid_request
  end
end
