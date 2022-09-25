class MapFacade

  class << self

    def city_lat_long(location)
      city = location.split(",")[0]
      state = location.split(",")[1]
      json = MapService.get_lat_long(city, state)
      lat_long = json[:results][0][:locations][0][:latLng]
    end
  end
end