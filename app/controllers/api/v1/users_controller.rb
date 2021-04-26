class Api::V1::UsersController < ApplicationController
  def register
    user = build_user
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      invalid_registration(user.errors.full_messages)
    end
  end

  private

  def build_user
    User.new(
      email: normalize_info[:email],
      password: normalize_info[:password],
      password_confirmation: normalize_info[:password_confirmation]
    )
  end
end
