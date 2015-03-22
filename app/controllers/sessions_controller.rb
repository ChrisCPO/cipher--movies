class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params_email)
    @user = @user.authenticate(params_password)

    if @user
      session[:user_id] = @user.id

      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end

  private

  def params_password
    params[:session][:password]
  end

  def params_email
    params[:session][:email]
  end
end
