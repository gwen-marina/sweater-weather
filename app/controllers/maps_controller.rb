class MapsController < ApplicationController 

  def results 
    @city = MapFacade.city_lat_long(params[:city], params[:state])
  end
end