require 'rails_helper'  

RSpec.describe 'Destination City Forecast And Salary', type: :request do
  scenario 'Happy Path ~ Teleport API finds tech salary for destination city' do
    params = {
      destination: 'chicago'
    }
    get api_v1_salaries_path, params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end