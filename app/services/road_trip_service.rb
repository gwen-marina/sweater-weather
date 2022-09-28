class RoadTripService 

  class << self 

    def conn 
      Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
        faraday.params['key'] = ENV['mapquest_api_key']
      end
    end
    
    def json_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_road_trip(origin, destination)
      response = conn.get("/directions/v2/route?from=#{origin}&to=#{destination}")
      json_response(response)
    end
  end
end