require 'rails_helper'

RSpec.describe DailyWeather do 

  it 'exisits and has attributes' do 
    response = File.read('spec/fixtures/forecast.json')
    data = JSON.parse(response, symbolize_names: true)
    daily_weather = DailyWeather.new(data[:daily][0])

    expect(daily_weather).to be_a(DailyWeather)
    expect(daily_weather.sunrise).to eq("2022-09-23 05:48:31 -0700")
    expect(daily_weather.sunset).to eq("2022-09-23 17:56:04 -0700")
    expect(daily_weather.max_temp).to eq(81.23)
    expect(daily_weather.min_temp).to eq(58.73)
    expect(daily_weather.conditions).to eq("clear sky")
    expect(daily_weather.icon).to eq("01d")
  end 
end