class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: normalize_info[:email].downcase)
    if user.present? && user.authenticate(normalize_info[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      bad_credentials
    end
  end

  private

  def bad_credentials
    render json: { 'message': { 'bad_credentials': 'Incorrect Credentials' } },
           status: :bad_request
  end
end
