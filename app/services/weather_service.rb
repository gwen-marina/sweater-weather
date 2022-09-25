class WeatherService

  class << self

    def conn
      Faraday.new(url: "https://api.openweathermap.org") do |faraday|
        faraday.params['appid'] = ENV['open_weather_api_key']
      end
    end

    def json_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_forecast(latitude, longitude)
      response = conn.get("/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&units=imperial&exclude=minutely")
      json_response(response)
    end
  end
end