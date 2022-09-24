require 'rails_helper'

RSpec.describe MapService do 

  it 'retrieves city and state data', :vcr do
    city = 'vail'
    state = 'arizona'
    parsed_json = MapService.get_lat_long(city, state)
    expect(parsed_json).to be_a Hash
    expect(parsed_json[:results]).to be_an Array

    city_state_data = parsed_json[:results][0][:locations][0]
    expect(city_state_data).to include(:latLng)
    expect(city_state_data[:latLng]).to be_a Hash
  end
end