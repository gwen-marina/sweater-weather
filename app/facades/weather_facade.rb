class WeatherFacade 

  class << self

    def weather_data(lat_long)
      json = WeatherService.get_forecast(lat_long[:lat], lat_long[:lng])
      data = ForecastSerializer.create_forecast(json)
    end
  end
end