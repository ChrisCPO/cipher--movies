class WatchListsController < ApplicationController
  def show
    @movies = aquire_movies
  end

 def create
   temp_movie = aquire_movie
   @movie = find_movie || Movie.new(temp_movie.local_db_movie_info_hash)

   if @movie.save
     current_user.add_movie(@movie)
     redirect_to session[:last_search]
   else
     redirect_to session[[:last_search]]
   end
 end

  private

  def find_movie
    Movie.find_by_id(movie_params)
  end

  def aquire_movie
    movie_data = itunes_results(movie_params)[:results][0]
    TemporaryMovie.new(movie_data)
  end

  def aquire_movies
    itunes_results(query_movie_ids)[:results].map do |movie_data|
      TemporaryMovie.new(movie_data)
    end
  end

  def query_movie_ids
   movies = current_user.movies.map { |movie| movie.id }
   movies.join(",")
  end

  def itunes_results(query_data)
    data_retriever.get_data(query_data, search_by_id: true  )
  end

  def movie_params
    params[:movie_id]
  end
end
