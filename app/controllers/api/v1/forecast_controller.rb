class Api::V1::ForecastController < ApplicationController

  def weather_forecast 
    lat_long = MapFacade.city_lat_long(params[:location])
    data =  WeatherFacade.weather_data(lat_long)
    render json: data
  end
end