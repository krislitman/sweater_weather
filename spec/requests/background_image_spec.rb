require 'rails_helper'

RSpec.describe 'Background Image for the City' do
  scenario 'Sad Path ~ With no parameter I receieve an error message' do
    get '/api/v1/backgrounds?location='

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(data[:message][:invalid_request]).to eq('Your parameters are bad and you should feel bad')
  end
end