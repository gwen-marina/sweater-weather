class RoadTripFacade

  class << self

    def road_trip_route(origin, destination)
      data = RoadTripService.get_road_trip(origin, destination)
      if data[:info][:statuscode] == 402
        return RoadTripSerializer.do_not_create_road_trip(data, origin, destination)
      else
        lat_long = MapFacade.city_lat_long(destination)
        forecast = WeatherFacade.weather_data(lat_long)
        RoadTripSerializer.create_road_trip(data, origin, destination, forecast)
      end
    end   
  end
end

 
