require "json"
require "net/http"

class DataRetriever
  include ActiveModel::Model
  attr_reader :search_info

  def get_data(seach_info)
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
    Net::HTTP.get(url)
  end

  def url
    URI("https://itunes.apple.com/search?term=#{search_info}&entity=movie")
  end
end
