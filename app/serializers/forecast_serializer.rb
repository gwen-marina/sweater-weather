class ForecastSerializer
  class << self

    def create_forecast(data)
      {
        data:
        {
            id: nil,
            type: 'forecast',
            attributes: {
              current_weather: {
                datetime: Time.at(data[:current][:dt]),
                sunrise: Time.at(data[:current][:sunrise]),
                sunset: Time.at(data[:current][:sunset]),
                temperature: data[:current][:temp],
                feels_like: data[:current][:feels_like],
                humidity: data[:current][:humidity],
                uvi: data[:current][:uvi],
                visibility: data[:current][:visibility],
                conditions: data[:current][:weather][0][:description],
                icon: data[:current][:weather][0][:icon]
              },
              daily_weather: data[:daily].map do |day| 
                {
                date: Time.at(day[:dt]),
                sunrise: Time.at(day[:sunrise]),
                sunset: Time.at(day[:sunset]),
                max_temp: day[:temp][:max],
                min_temp: day[:temp][:min],
                conditions: day[:weather][0][:description],
                icon: day[:weather][0][:icon]
                }
              end.first(5),
              hourly_weather: data[:hourly].map do |hour| 
                {
                  time: Time.at(hour[:dt]),
                  temperature: hour[:temp],
                  conditions: hour[:weather][0][:description],
                  icon: hour[:weather][0][:icon]
                }
              end.first(8)
            } 
        }
      }
     
    end
  end
end

