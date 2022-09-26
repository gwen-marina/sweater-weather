require 'rails_helper'

RSpec.describe 'Forecast API' do 
  
  it 'can return a list of current weather stats', :vcr do 
    location = 'vail,az'
    get "/api/v1/forecast?location=#{location}"
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(400)
    
    weather_response = JSON.parse(response.body, symbolize_names: true)
    weather = weather_response[:data]

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
    expect(weather[:attributes][:current_weather][:humidity]).to be_an(Integer).or be_a(Float)

    expect(weather[:attributes][:current_weather]).to have_key(:uvi)
    expect(weather[:attributes][:current_weather][:uvi]).to be_an(Integer).or be_a(Float)

    expect(weather[:attributes][:current_weather]).to have_key(:visibility)
    expect(weather[:attributes][:current_weather][:visibility]).to be_an(Integer).or be_a(Float)

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

  it 'can return a list of daily weather stats for the next 5 days', :vcr do 
    location = 'vail,az'
    get "/api/v1/forecast?location=#{location}"
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(400)
    
    daily_weather_response = JSON.parse(response.body, symbolize_names: true)
    daily = daily_weather_response[:data]

    expect(daily).to have_key(:id)
    expect(daily[:id]).to be(nil)
    expect(daily[:type]).to eq('forecast')

    expect(daily[:attributes][:daily_weather][0]).to have_key(:date)
    expect(daily[:attributes][:daily_weather][0][:date]).to be_a String

    expect(daily[:attributes][:daily_weather][0]).to have_key(:sunrise)
    expect(daily[:attributes][:daily_weather][0][:sunrise]).to be_a String

    expect(daily[:attributes][:daily_weather][0]).to have_key(:sunset)
    expect(daily[:attributes][:daily_weather][0][:sunset]).to be_a String

    expect(daily[:attributes][:daily_weather][0]).to have_key(:max_temp)
    expect(daily[:attributes][:daily_weather][0][:max_temp]).to be_a Float

    expect(daily[:attributes][:daily_weather][0]).to have_key(:min_temp)
    expect(daily[:attributes][:daily_weather][0][:min_temp]).to be_a Float

    expect(daily[:attributes][:daily_weather][0]).to have_key(:conditions)
    expect(daily[:attributes][:daily_weather][0][:conditions]).to be_a String

    expect(daily[:attributes][:daily_weather][0]).to have_key(:icon)
    expect(daily[:attributes][:daily_weather][0][:icon]).to be_a String

    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:pressure)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:dew_point)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:humidity)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:wind_speed)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:wind_deg)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:feels_like)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:moonrise)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:moonset)
    expect(daily[:attributes][:daily_weather][0]).to_not have_key(:moon_phase)
  end

  it 'can return a list of hourly weather stats for the next 8 hours', :vcr do 
    location = 'vail,az'
    get "/api/v1/forecast?location=#{location}"
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(400)
    
    hourly_weather_response = JSON.parse(response.body, symbolize_names: true)
    hourly = hourly_weather_response[:data]

    expect(hourly).to have_key(:id)
    expect(hourly[:id]).to be(nil)
    expect(hourly[:type]).to eq('forecast')

    expect(hourly[:attributes][:hourly_weather][0]).to have_key(:time)
    expect(hourly[:attributes][:hourly_weather][0][:time]).to be_a String

    expect(hourly[:attributes][:hourly_weather][0]).to have_key(:temperature)
    expect(hourly[:attributes][:hourly_weather][0][:temperature]).to be_a Float

    expect(hourly[:attributes][:hourly_weather][0]).to have_key(:conditions)
    expect(hourly[:attributes][:hourly_weather][0][:conditions]).to be_a String

    expect(hourly[:attributes][:hourly_weather][0]).to have_key(:icon)
    expect(hourly[:attributes][:hourly_weather][0][:icon]).to be_a String

    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:pressure)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:dew_point)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:humidity)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:wind_speed)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:wind_deg)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:wind_gust)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:feels_like)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:uvi)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:clouds)
    expect(hourly[:attributes][:hourly_weather][0]).to_not have_key(:visibility)
  end
end