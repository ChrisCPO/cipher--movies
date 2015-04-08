class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :name, :password))
    if @user.save
      redirect_to new_session_path, :notice => "Signed up!"
    else
      render "new", :notice => "User creation failed. Please try again."
    end
  end
end
