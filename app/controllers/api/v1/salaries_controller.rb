class Api::V1::SalariesController < ApplicationController
  def tech_salaries
    begin
      salaries = SalariesFacade.new(params[:destination])
      render json: SalariesSerializer.new(salaries)
    rescue
      invalid_request
    end
  end
end