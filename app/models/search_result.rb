class SearchResult
  include ActiveModel::Model
  attr_accessor :count, :movies, :query

  def no_results?
    count == 0
  end
end
