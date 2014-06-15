class Api::V1::UsersController < ApplicationController

  respond_to :json
  # GET /outlet_types
  def index
    authorize! params(:user), User
   	if current_user.admin?
   		render json: current_user, status: :ok
   	else 
    	render json: current_user, status: :ok
    end 
  end

# Example of strong params
  # def user_params 
  #   params.require(:user).permit(:authentication_token, :email)
  # end 
  
end
