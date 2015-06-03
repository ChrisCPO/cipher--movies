class MoviesController < ApplicationController
  helper_method :subscribe, :notify

  def index
    @movies = Movie.all
  end

  def new
    if params[:movie] != nil
      @movie = find_movie(params[:movie])
    end
    puts @movie
    puts @movie_status
  end

  def create
    binding.pry
    movie = Movie.new(name: @movie, user_id: current_user.id)
    if @movie != nil && @movie_status == false
      movie.save
      subscribe(@movie)
      redirect_to :movies
    elsif @movie != nil
      movie.update(subscribed: true, notified: true)
      movie.save
      redirect_to :movies
    end
  end

  private

    def find_movie(name)
      response =  JSON.parse(HTTParty.get("https://itunes.apple.com/search?entity=movie&term=#{name}").body)

      if response["resultCount"] == 0
        @movie_status = false
        return name
      else
        response["results"].first["trackName"]
      end
    end

    def movie_search(movie)
      Movie.where(name: movie).each do |movie|
        response =  JSON.parse(HTTParty.get("https://itunes.apple.com/search?entity=movie&term=#{movie.name}").body)
        if response["resultCount"] != 0
          notify(movie.name)
        end
      end
    end

    def subscribe(movie)
      movies = Movie.where(name: movie, user_id: current_user.id, subscribed: false, notified: false)
      movies.each do |movie|
        movie.update(subscribed: true)
      end
      ModelMailer.new_record_notification(current_user.name, current_user.email, movie).deliver
    end

    def notify(movie)
      movies = Movie.where(name: movie, user_id: current_user.id, subscribed: true, notified: false)
      movies.each do |movie|
        movie.update(notified: true)
      end
      ModelMailer.movie_available_email(current_user.name, current_user.email, movie).deliver
    end

    def movie_params
      params.require(:movie).permit(:subscribed, :notified)
    end
end
