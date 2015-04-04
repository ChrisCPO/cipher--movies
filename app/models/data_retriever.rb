require "json"
require "net/http"

class DataRetriever
  include ActiveModel::Model
  attr_reader :search_info, :search_by_id
  attr_accessor :url

  def get_data(search_info, options = {})
    @search_by_id = options[:search_by_id] ||= false
    @search_info = search_info
    indifferent_hash
  end

  private

  def indifferent_hash
    json_convert.with_indifferent_access
  end

  def json_convert
    JSON.parse(net_info)
  end

  def net_info
    set_url
    Net::HTTP.get(URI(url))
  end

  def set_url
    if search_by_id?
      self.url = search_by_id_url
    else
      self.url = search_movies_url
    end
  end

  def search_movies_url
    "https://itunes.apple.com/search?term=#{search_words}&entity=movie"
  end

  def search_by_id_url
    "https://itunes.apple.com/lookup?id=#{search_info}"
  end

  def search_words
    search_info.strip.gsub(" ", "+")
  end

  def search_by_id?
    @search_by_id
  end
end
