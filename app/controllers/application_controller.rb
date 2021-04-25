class ApplicationController < ActionController::API
  def invalid_request
    render json: { 'message': { 'invalid_request': 'Your parameters are bad and you should feel bad' } },
           status: :bad_request
  end
  def invalid_registration(messages)
    render json: { 'message': { 'invalid_request': "#{messages}" } },
           status: :bad_request
  end
end
