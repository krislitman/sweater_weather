class ApplicationController < ActionController::API
  def invalid_request
    render json: { 'message': { 'invalid_request': 'Your parameters are bad and you should feel bad' } },
           status: :bad_request
  end

  def invalid_registration(messages)
    render json: { 'message': { 'invalid_request': messages.to_s } },
           status: :bad_request
  end

  def unauthorized_user
    render json: { 'message': { 'unauthorized': 'Incorrect Key' } },
           status: :unauthorized
  end

  def normalize_info
    raw = request.body.read
    clean = raw.gsub(/\n/, '')
    JSON.parse(clean, symbolize_names: true)
  end
end
