class MapService

  class << self

    def conn
      Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
        faraday.params['key'] = ENV['mapquest_api_key']
      end
    end

    def json_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_lat_long(city, state)
      response = conn.get("/geocoding/v1/address?city=#{city}&state=#{state}")
      json_response(response)
    end
  end
end