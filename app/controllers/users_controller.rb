class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user = @user.authenticate(params_password)
      session[:user_id] = @user.id

      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def params_password
    params[:user][:password]
  end
end
