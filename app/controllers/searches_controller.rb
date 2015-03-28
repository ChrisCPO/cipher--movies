class SearchesController < ApplicationController
  def show
    @results = aquire_movies
  end

  private

  def aquire_movies
    movies = []
    itunes_results[:results].each do |movie_info|
     movies << SearchedMovie.new(movie_info)
    end
    movies
  end

  def itunes_results
    inquire = params[:search]
    data_retriever.get_data(inquire)
  end
end
