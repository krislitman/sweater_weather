class Api::V1::SalariesController < ApplicationController
  def tech_salaries
    salaries = SalariesFacade.new(params[:destination])
    render json: SalariesSerializer.new(salaries)
  end
end