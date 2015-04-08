class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    if params[:movie] != nil
      @movie = find_movie(params[:movie])
    end
  end

  def create
    movie = Movie.create(name: params[:movie], user_id: current_user.id)
    redirect_to :movies
  end

  def find_movie(name)
    JSON.parse( 
      HTTParty.get("https://itunes.apple.com/search?entity=movie&term=#{name}").body 
      )["results"].first["trackName"]
  end
end
