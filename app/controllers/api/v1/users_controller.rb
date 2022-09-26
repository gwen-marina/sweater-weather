class Api::V1::UsersController < ApplicationController

 def create
  user = User.new(user_params)  
   if user.save
    user.generate_api_key
    render json: UserSerializer.create_user(user), status: 201
   else
    render json: { status: 400, message: "#{user.errors.full_messages.to_sentence}"}
    end
  end

  private 
  
  def user_params 
     params.permit(:email, :password, :password_confirmation)
  end
end