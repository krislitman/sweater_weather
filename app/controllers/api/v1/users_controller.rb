class Api::V1::UsersController < ApplicationController
  def register
    
    require 'pry'; binding.pry
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end