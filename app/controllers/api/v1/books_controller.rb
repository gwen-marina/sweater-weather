class Api::V1::BooksController < ApplicationController

  def search
    location = params[:location]
    quantity = params[:quantity]
    if location.present? && quantity.present?
      lat_long = MapFacade.city_lat_long(location)
      forecast =  WeatherFacade.weather_data(lat_long)
      books = BookFacade.find_books(location)
      render json: BookSerializer.create_book(forecast, books, quantity, location)
    elsif !quantity
      render json: { message: 'Invalid Quantity' } 
    else  
      render status: 404
    end
  end
end