class MoviesController < ApplicationController
  def show
    @movie = aquire_movie
  end

  private

  def aquire_movie
    movie_data = itunes_results[:results][0]
    SearchedMovie.new(movie_data)
  end

  def itunes_results
    data_retriever.get_data(params[:id], search_by_id: true)
  end
end
