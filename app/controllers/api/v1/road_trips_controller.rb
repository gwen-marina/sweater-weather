class Api::V1::RoadTripsController < ApplicationController 

  def create 
    user = User.find_by(api_key: params[:api_key])
    if user.nil? 
      render status: 401, json: { message: "Invalid API Key." }
    else 
      data = RoadTripFacade.road_trip_route(params[:origin], params[:destination])
      render json: data
    end
  end
end                  