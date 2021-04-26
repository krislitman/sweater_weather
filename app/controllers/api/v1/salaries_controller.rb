class Api::V1::SalariesController < ApplicationController
  def tech_salaries
    response = conn.get("api/urban_areas/slug:#{params[:destination]}/salaries")
    expected = JSON.parse(response.body, symbolize_names: true)
    expected[:salaries].map do |data|
      Job.new(data)
    end
    require 'pry'; binding.pry
  end

  private

  def conn
    Faraday.new('http://api.teleport.org')
  end
end