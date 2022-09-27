class RoadTripFacade

  class << self

    def road_trip_route(origin, destination)
      json = RoadTripService.get_road_trip(origin, destination)
    end
  end
end