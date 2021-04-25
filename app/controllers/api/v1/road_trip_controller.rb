class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: normalize_info[:api_key])
    if user.nil?
      unauthorized_user
    else
    end
  end
end