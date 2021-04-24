class Api::V1::WeatherController < ApplicationController
  def get_forecast
    begin
      data = WeatherFacade.new(params[:location])
      render json: ForecastSerializer.new(data)
    rescue
      invalid_request
    end
  end
end