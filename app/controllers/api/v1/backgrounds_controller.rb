class Api::V1::BackgroundsController < ApplicationController
  def background_image
    begin
      BackgroundsService.get_image(params[:location])
    rescue
      invalid_request
    end
  end
end