class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: normalize_info[:api_key])
    if user.nil?
      unauthorized_user
    else
      return if check_params
      road_trip = RoadTripFacade.new(normalize_info)
      if road_trip.weather_at_eta[:conditions] == 'impossible'
        render json: RoadtripSerializer.new(road_trip), status: :bad_request
      elsif road_trip.start_city == road_trip.end_city
        render json: RoadtripSerializer.new(road_trip), status: :accepted
      else
        render json: RoadtripSerializer.new(road_trip), status: :created
      end
    end
  end

  private

  def check_params
    invalid_request if normalize_info[:origin].blank? || normalize_info[:destination].blank?
  end
end
