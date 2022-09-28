class Api::V1::SessionsController < ApplicationController
   
  def create
    user = User.find_by(email: params[:email]) 
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.create_user(user)
    else
      render status: 400, json: { message: "Email or Password is incorrect, please try again." }
    end
  end
end