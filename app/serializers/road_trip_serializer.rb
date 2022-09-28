class RoadTripSerializer 

  class << self 

    def create_road_trip(data, origin, destination, forecast)
      {
        data: 
        {
          id: nil,
          type: "roadtrip",
          attributes: {
            start_city: origin,
            end_city: destination,
            travel_time: travel_time_formatted(data),
            weather_at_eta: {
              temperature: arrival_eta_forecast(data, forecast)[0].temperature,
              conditions: arrival_eta_forecast(data, forecast)[0].conditions
            }
          }
        }
      }
    end

    def do_not_create_road_trip(data, origin, destination)
      {
        data: 
        {
          id: nil,
          type: "roadtrip",
          attributes: {
            start_city: origin,
            end_city: destination,
            travel_time: "Impossible",
            weather_at_eta: {
              temperature: "",
              conditions: ""
            }
          }
        }
      }
    end

    def travel_time_formatted(data)
      hours = data[:route][:formattedTime].split(":")[0]
      minutes = data[:route][:formattedTime].split(":")[1]
      (hours + " hours,") + (minutes + " minutes")
    end

    def arrival_eta_forecast(data, forecast)
      hours = data[:route][:formattedTime].split(":")[0]
      arrival_time = Time.now + data[:route][:realTime] 
      if hours.to_i <= 48 
        arrival_forecast = get_arrival_forecast_hourly(forecast, arrival_time)
      elsif hours.to_i > 48 
        arrival_forecast = get_arrival_forecast_daily(forecast, arrival_time)
      end
      arrival_forecast
    end
    
    def get_arrival_forecast_hourly(forecast, arrival_time)
      arrival_day = forecast[:data][:attributes][:hourly_weather].select {|hour| hour.time == arrival_time.beginning_of_hour }
    end

    def get_arrival_forecast_daily(forecast, arrival_time)
      arrival_day = forecast[:data][:attributes][:daily_weather].select {|day| day.date > arrival_time.beginning_of_day && day[:date] < arrival_time.end_of_day}
    end
  end
end