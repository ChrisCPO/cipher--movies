class SearchesController < ApplicationController
  attr_reader :results

  def show
    @results = aquire_movies
    save_search_link
  end

  private

  def save_search_link
    session[:last_search] = request.fullpath
  end

  def aquire_movies
    itunes_results[:results].map do |movie_info|
      TemporaryMovie.new(movie_info)
    end
  end

  def itunes_results
    inquire = params[:search]
    data_retriever.get_data(inquire)
  end
end
