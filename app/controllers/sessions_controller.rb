class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # AUTHENTICATION!! Ie sign the user in
      session[:user_id] = user.id

      # Send them on their way
      redirect_to new_movie_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    # Log user out!
    session[:user_id] = nil

    # Send them on their way
    redirect_to sessions_new_path, :notice => "Logged out!"
  end
end
