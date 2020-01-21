class UsersController < ApplicationController
  before_action :require_xhr_request

  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def create
    @user = User.new(permitted_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.details, status: :unprocessable_entity
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(permitted_params)
      render json: @user
    else
      render json: @user.errors.details, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end
  
private
  def require_xhr_request
    return head(:bad_request) unless request.xhr?
  end
  
  def permitted_params
    params.require(:user).permit(
      :email, :role, :name, :phone,
      advertiser_info_attributes: [:organisation, :position]
    )    
  end
end
