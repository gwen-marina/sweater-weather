require 'rails_helper'

RSpec.describe 'RoadTrip API' do 
  
  it 'can return a list of road trip data for under 48 hours', :vcr do 
    user = User.create!(email: "imadog@dogmail.com", password: "steak", password_confirmation: "steak", api_key: "12345" )
    body =  {
      "origin": "denver,co",
      "destination": "tucson,az",
      "api_key": "12345"
    } 
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(401)
    
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end

  it 'can return a list of road trip data for over 48 hours', :vcr do 
    user = User.create!(email: "imadog@dogmail.com", password: "steak", password_confirmation: "steak", api_key: "12345" )
    body =  {
      "origin": "washington,dc",
      "destination": "panamacity,panama",
      "api_key": "12345"
    } 
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(401)
    
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end

  it 'returns an error response for an incorrect api key', :vcr do 
    user = User.create!(email: "imadog@dogmail.com", password: "steak", password_confirmation: "steak", api_key: "12345" )
    body =  {
      "origin": "denver,co",
      "destination": "tucson,az",
      "api_key": "1234"
    } 
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(401)
    expect(road_trip).to have_key(:message)
    expect(road_trip[:message]).to eq("Invalid API Key.")
  end

  it 'returns an error if no api key is sent', :vcr do 
    user = User.create!(email: "imadog@dogmail.com", password: "steak", password_confirmation: "steak", api_key: "1234")
    body =  {
      "origin": "denver,co",
      "destination": "tucson,az"
    } 
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(401)
    expect(road_trip).to have_key(:message)
    expect(road_trip[:message]).to eq("Invalid API Key.")
  end

  it 'returns travel time impossible when route can not be mapped', :vcr do
    user = User.create!(email: "imadog@dogmail.com", password: "steak", password_confirmation: "steak", api_key: "12345" )
    body =  {
      "origin": "denver,co",
      "destination": "maui,hawaii",
      "api_key": "12345"
    } 

    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible")
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end
end