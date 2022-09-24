class MapFacade

  class << self

    def city_lat_long(city, state)
      json = MapService.get_lat_long(city, state)
    end
  end
end