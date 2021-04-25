class Api::V1::UsersController < ApplicationController
  def register
    user = User.new(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      invalid_registration(user.errors.full_messages)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end