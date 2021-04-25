class Api::V1::BackgroundsController < ApplicationController
  def background_image
    image = BackgroundsFacade.new(params[:location])
    render json: BackgroundsSerializer.new(image)
  rescue StandardError
    invalid_request
  end
end
