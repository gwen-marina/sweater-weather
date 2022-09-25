require 'rails_helper'

RSpec.describe 'Forecast API' do 
  
  it 'can return a list of current weather stats', :vcr do 
    location = 'vail,az'
    get "/api/v1/forecast?location=#{location}"
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(400)
    
    current_weather_response = JSON.parse(response.body, symbolize_names: true)
    weather = current_weather_response[:data]

    expect(weather).to have_key(:id)
    expect(weather[:id]).to be(nil)
    expect(weather[:type]).to eq('forecast')

    expect(weather[:attributes][:current_weather]).to have_key(:datetime)
    expect(weather[:attributes][:current_weather][:datetime]).to be_a String

    expect(weather[:attributes][:current_weather]).to have_key(:sunrise)
    expect(weather[:attributes][:current_weather][:sunrise]).to be_a String

    expect(weather[:attributes][:current_weather]).to have_key(:sunset)
    expect(weather[:attributes][:current_weather][:sunset]).to be_a String

    expect(weather[:attributes][:current_weather]).to have_key(:temperature)
    expect(weather[:attributes][:current_weather][:temperature]).to be_a Float

    expect(weather[:attributes][:current_weather]).to have_key(:feels_like)
    expect(weather[:attributes][:current_weather][:feels_like]).to be_a Float

    expect(weather[:attributes][:current_weather]).to have_key(:humidity)
    expect(weather[:attributes][:current_weather][:humidity]).to be_an Integer

    expect(weather[:attributes][:current_weather]).to have_key(:uvi)
    expect(weather[:attributes][:current_weather][:uvi]).to be_a Float

    expect(weather[:attributes][:current_weather]).to have_key(:visibility)
    expect(weather[:attributes][:current_weather][:visibility]).to be_an Integer

    expect(weather[:attributes][:current_weather]).to have_key(:conditions)
    expect(weather[:attributes][:current_weather][:conditions]).to be_a String

    expect(weather[:attributes][:current_weather]).to have_key(:icon)
    expect(weather[:attributes][:current_weather][:icon]).to be_a String

    expect(weather[:attributes][:current_weather]).to_not have_key(:pressure)
    expect(weather[:attributes][:current_weather]).to_not have_key(:dew_point)
    expect(weather[:attributes][:current_weather]).to_not have_key(:clouds)
    expect(weather[:attributes][:current_weather]).to_not have_key(:wind_speed)
    expect(weather[:attributes][:current_weather]).to_not have_key(:wind_deg)
  end
end