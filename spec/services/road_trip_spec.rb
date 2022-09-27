require 'rails_helper'

RSpec.describe RoadTripService do 

  it 'retrieves information for a destination', :vcr do
    origin = 'vail,az'
    destination = 'denver,co'
    parsed_json = RoadTripService.get_road_trip(origin, destination)
    expect(parsed_json).to be_a Hash
  end
end