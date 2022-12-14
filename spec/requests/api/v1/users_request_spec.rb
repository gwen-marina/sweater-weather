require 'rails_helper'

RSpec.describe 'Users API' do 

  it 'can return a list of user data', :vcr do 
    params = {
      "email":"person4@woohoo.com",
      "password":"abc123",
      "password_confirmation":"abc123"
    }

    post "/api/v1/users", params: params
    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(201)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:data)
    expect(results[:data]).to be_a(Hash)
    expect(results[:data].keys.count).to eq(3)

    data = results[:data]
    expect(data).to have_key(:type)
    expect(data[:type]).to eq('users')

    expect(data).to have_key(:id)
    expect(data[:id]).to be_an(Integer)

    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to be_a(Hash)
    expect(data[:attributes].keys.count).to eq(2)

    expect(data[:attributes]).to have_key(:email)
    expect(data[:attributes][:email]).to be_a(String)

    expect(data[:attributes]).to have_key(:api_key)
    expect(data[:attributes][:api_key]).to be_a(String)
  end

  it 'returns an error message if email is already taken' do
    user = User.create!(email: "person4@woohoo.com", password: "123", password_confirmation: "123")

    headers = { 'Content-Type': 'application/json' }
    params = {
              "email": "person4@woohoo.com",
              "password": "12345",
              "password_confirmation": "12345"
             }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(status).to eq(400)
    expect(invalid[:message]).to eq('Email has already been taken')
  end

  it 'returns an error message when the passwords do not match' do
    data = {
      "email": "person4@woohoo.com",
      "password": "1234",
      "password_confirmation": "12345"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(status).to eq(400)
    expect(invalid[:message]).to eq("Password confirmation doesn't match Password")
  end
end

