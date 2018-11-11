class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all
    #.page(param[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'Registered User'
      redirect_to @user
    else
      flash.now[:danger] = 'Failed to Register'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
