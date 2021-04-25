require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  scenario 'Sad Path ~ With missing params you get 400 response' do
    User.destroy_all
    params = {
      "email": "email@example.com",
      "password": "",
      "password_confirmation": ""
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}

    post api_v1_users_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(expected.keys).to include(:message)
    expect(expected[:message].keys).to include(:invalid_request)
    expect(expected[:message][:invalid_request]).to include("Password can't be blank")
    expect(expected[:message][:invalid_request]).to include("Password confirmation doesn't match Password")
  end
  scenario 'Sad Path ~ When passwords dont match you have a bad time' do
    User.destroy_all
    params = {
      "email": "email@example.com",
      "password": "this_is_my_first_attempt",
      "password_confirmation": "oh_no_i_dont_match"
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}
    
    post api_v1_users_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(expected[:message][:invalid_request]).to include("Password confirmation doesn't match Password")
  end
  scenario 'Sad Path ~ If the email is taken it wont do what you want' do
    User.destroy_all
    User.create(
      email: "email@example.com",
      password: "password"
    )
    params = {
      "email": "email@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}

    post api_v1_users_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq 400
    expect(expected[:message][:invalid_request]).to include("Email has already been taken")
  end
  scenario 'Happy Path ~ User can be created' do
    User.destroy_all
    params = {
      "email": "email@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json',
       'ACCEPT' => 'application/json'}

    post api_v1_users_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq 201
    expect(expected.keys).to include(:data)
    expect(expected[:data].keys).to include(:id)
    expect(expected[:data].keys).to include(:type)
    expect(expected[:data].keys).to include(:attributes)
    expect(expected[:data][:attributes].keys).to include(:email)
    expect(expected[:data][:attributes].keys).to include(:api_key)
  end
end