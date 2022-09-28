require 'rails_helper'

RSpec.describe HourlyWeather do 

  it 'exisits and has attributes' do 
    response = File.read('spec/fixtures/forecast.json')
    data = JSON.parse(response, symbolize_names: true)
    hourly_weather = HourlyWeather.new(data[:hourly][0])

    expect(hourly_weather).to be_an(HourlyWeather)
    expect(hourly_weather.time).to eq("2022-09-23 14:00:00 -0700")
    expect(hourly_weather.temperature).to eq(81.23)
    expect(hourly_weather.conditions).to eq("clear sky")
    expect(hourly_weather.icon).to eq("01d")
  end 
end