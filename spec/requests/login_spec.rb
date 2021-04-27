require 'rails_helper'

RSpec.describe 'Login', type: :request do
  scenario 'Sad Path ~ Password doesnt match, 400 response' do
    User.destroy_all
    User.create(
      email: "email@example.com",
      password: "password"
    )
    params = {
      "email": "email@example.com",
      "password": "1234",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected.keys).to include(:message)
    expect(expected[:message].keys).to include(:bad_credentials)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Sad Path ~ Email doesnt match, 400 response' do
    User.destroy_all
    User.create(
      email: "email2@example.com",
      password: "password"
    )
    params = {
      "email": "email@example.com",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Sad Path ~ Empty makes things fail 1 of 3' do
    User.destroy_all
    User.create(
      email: "email2@example.com",
      password: "password"
    )
    params = {
      "email": "",
      "password": "",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Sad Path ~ Empty makes things fail 2 of 3' do
    User.destroy_all
    User.create(
      email: "email2@example.com",
      password: "password"
    )
    params = {
      "email": "email2@example.com",
      "password": "",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Sad Path ~ Empty makes things fail 3 of 3' do
    User.destroy_all
    User.create(
      email: "email2@example.com",
      password: "password"
    )
    params = {
      "email": "",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Sad Path ~ If the user doesnt exist it still fails' do
    User.destroy_all
    params = {
      "email": "email@example.com",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    
    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(expected[:message][:bad_credentials]).to include("Incorrect Credentials")
  end
  scenario 'Happy Path ~ Can be logged in with 200 status code' do
    User.destroy_all
    user1 = User.create(
      email: "email2@example.com",
      password: "password"
    )
    params = {
      "email": "email2@example.com",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
  
    post api_v1_sessions_path, headers: headers, params: JSON.generate(params)
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(expected.keys).to include(:data)
    expect(expected[:data].keys).to include(:id)
    expect(expected[:data].keys).to include(:type)
    expect(expected[:data].keys).to include(:attributes)
    expect(expected[:data][:attributes].keys).to include(:email)
    expect(expected[:data][:attributes].keys).to include(:api_key)
    expect(expected[:data][:attributes][:email]).to eq(user1.email)
  end
end