require 'rails_helper'

RSpec.describe 'Retrieve weather for a city' do
  scenario 'It can take in location and get forecast' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end