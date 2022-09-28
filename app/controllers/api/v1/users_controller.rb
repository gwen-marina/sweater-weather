class Api::V1::UsersController < ApplicationController

 def create
  user = User.create(user_params)  
  user.generate_api_key
   if user.save
    render json: UserSerializer.create_user(user), status: 201
   else
    render status: 400, json: { message: "#{user.errors.full_messages.to_sentence}" }
    end
  end

  private 
  
  def user_params 
     params.permit(:email, :password, :password_confirmation)
  end
end