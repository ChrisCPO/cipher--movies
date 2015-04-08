class SearchesController < ApplicationController
  attr_reader :iresults

  def show
    @results = SearchResult.new(
                                movies: aquire_movies,
                                 count: iresults[:resultCount],
                                 query: params[:search]
                               )
    save_search_link
  end

  private

  def save_search_link
    session[:last_search] = request.fullpath
  end

  def aquire_movies
    @iresults = itunes_results
    iresults[:results].map do |movie_info|
      TemporaryMovie.new(movie_info)
    end
  end

  def itunes_results
    inquire = params[:search]
    data_retriever.get_data(inquire)
  end
end
