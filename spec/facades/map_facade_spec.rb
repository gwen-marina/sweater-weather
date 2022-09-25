require 'rails_helper'

RSpec.describe MapFacade do 
  it 'returns an array of objects', :vcr do 
    location = 'vail, az'
    map_objects = MapFacade.city_lat_long(location)

    expect(map_objects).to be_a Hash
  end
end