class ForecastSerializer
  class << self

    def create_forecast(data)
      {
        data:
        {
            id: nil,
            type: 'forecast',
            attributes: {
              current_weather: CurrentWeather.new(data),
              daily_weather: data[:daily].map do |day| 
                DailyWeather.new(day)
              end.first(5),
              hourly_weather: data[:hourly].map do |hour| 
                HourlyWeather.new(hour)
              end
            } 
        }
      }
     
    end
  end
end

