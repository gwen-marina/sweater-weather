require 'rails_helper'

RSpec.describe 'Sessions Request' do

  it 'returns a JSON payload' do
    data = {
            "email": "smudgerisadog@doggo.com",
            "password": "steak",
            "password_confirmation": "steak"
          }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)
    user = JSON.parse(response.body, symbolize_names: true)

    data_login = {
                  "email": "smudgerisadog@doggo.com",
                  "password": "steak"
                 }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user[:data]).to have_key(:type)
    expect(user[:data]).to have_key(:id)
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
  end

  it 'returns invalid credentials when password does not match' do
    data = {
            "email": "smudgerisadog@doggo.com",
            "password": "steak",
            "password_confirmation": "steak"
          }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
                  "email": "smudgerisadog@doggo.com",
                  "password": "ste"
                 }

    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:status]).to eq(400)
    expect(user).to have_key(:message)
    expect(user[:message]).to eq("Email or Password is incorrect, please try again.")
  end

  it 'returns invalid credentials when email does not match' do
    data = {
      "email": "smudgerisadog@doggo.com",
      "password": "steak",
      "password_confirmation": "steak"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
      "email": "smudgerisad@doggo.com",
      "password": "steak",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)
    
    expect(user[:status]).to eq(400)
    expect(user).to have_key(:message)
    expect(user[:message]).to eq("Email or Password is incorrect, please try again.")
  end

  it 'returns invalid credentials when email and password do not match' do
    data = {
      "email": "smudgerisadog@doggo.com",
      "password": "steak",
      "password_confirmation": "steak"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
      "email": "smudgrisado@doggo.com",
      "password": "stek",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:status]).to eq(400)
    expect(user).to have_key(:message)
    expect(user[:message]).to eq("Email or Password is incorrect, please try again.")
  end
end