class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    # If there isn't a searched movie in memory already, find one
    if params[:movie] != nil
      @movie = find_movie(params[:movie])

      # if you have already searched for this movie and it is not avialable, ask to subscribe to an email notification
      if Movie.where(name: @movie, user_id: current_user.id, subscribed: false, notified: false).name == @movie
        Movie.where(name: @movie, user_id: current_user.id, subscribed: false, notified: false).subscribed = true
        subscribe(@movie)
      elsif Movie.where(name: @movie, user_id: current_user.id, subscribed: true, notified: false).name == @movie
        Movie.where(name: @movie, user_id: current_user.id, subscribed: true, notified: false).notified = true
        notify(@movie)
      end
    end
  end

  def create
    movie = Movie.new(name: @movie, user_id: current_user.id)
    movie.save
    redirect_to :movies
  end

  def find_movie(name)
    JSON.parse(
      HTTParty.get("https://itunes.apple.com/search?entity=movie&term=#{name}").body
      )["results"].first["trackName"]
  end

  def subscribe(movie)
    ModelMailer.new_record_notification(current_user.name, current_user.email, movie).deliver
  end

  def notify(movie)
    ModelMailer.movie_available_email(current_user.name, current_user.email, movie).deliver
  end
end
