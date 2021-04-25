class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: normalize_info[:api_key])
    if user.nil?
      unauthorized_user
    else
      road_trip = RoadTripFacade.new(normalize_info)
      render json: RoadtripSerializer.new(road_trip), status: :created
    end
  end
end