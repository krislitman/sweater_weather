class Api::V1::BackgroundsController < ApplicationController
  def background_image
    begin
      image = BackgroundsFacade.new(params[:location])
      render json: BackgroundsSerializer.new(image)
    rescue
      invalid_request
    end
  end
end