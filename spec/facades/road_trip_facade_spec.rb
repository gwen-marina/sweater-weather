require 'rails_helper'

RSpec.describe RoadTripFacade do 

  it 'returns a data structure', :vcr do 
    origin = 'vail,az'
    destination = 'denver,co'
    road_trip = RoadTripFacade.road_trip_route(origin, destination)

    expect(road_trip).to be_a Hash
    expect(road_trip[:route]).to be_a Hash
  end
end