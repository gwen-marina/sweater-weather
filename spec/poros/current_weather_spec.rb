require 'rails_helper'

RSpec.describe CurrentWeather do 

  it 'exisits and has attributes' do 
    response = File.read('spec/fixtures/forecast.json')
    data = JSON.parse(response, symbolize_names: true)
    current_weather = CurrentWeather.new(data)
    
    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to eq("2022-09-23 14:33:27 -0700")
    expect(current_weather.sunrise).to eq("2022-09-23 05:48:31 -0700")
    expect(current_weather.sunset).to eq("2022-09-23 17:56:04 -0700")
    expect(current_weather.temperature).to eq(80.74)
    expect(current_weather.feels_like).to eq(78.94)
    expect(current_weather.humidity).to eq(18)
    expect(current_weather.uvi).to eq(2.9)
    expect(current_weather.visibility).to eq(10000)
    expect(current_weather.conditions).to eq("clear sky")
    expect(current_weather.icon).to eq("01d")
  end 
end