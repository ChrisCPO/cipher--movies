class SearchedMovie
  include ActiveModel::Model
  attr_reader :movie_info

  def initialize(movie_info)
    @movie_info = movie_info
  end

  def title
    movie_info[:trackName]
  end

  def apple_id
    movie_info[:trackId]
  end

  def release_date
   time = Date.parse(movie_info[:releaseDate])
   time.strftime("%b %e %Y")
  end

  def image_large
    movie_info[:artworkUrl100]
  end

  def apple_url
    movie_info[:trackViewUrl]
  end

  def content_advisory_rating
    movie_info[:contentAdvisoryRating]
  end

  def long_description
    movie_info[:longDescription]
  end

  def short_description
    movie_info[:shortDescription]
  end

  def genre
    movie_info[:primaryGenreName]
  end

  def length
    time = movie_info[:trackTimeMillis].to_i
    format_time(time)
  end

  private

  def format_time(time)
    secs, mil_secs = time.divmod(1000)
    mins, secs = secs.divmod(60)
    hours, mins = mins.divmod(60)
    days, hours = hours.divmod(24)
    "#{hours}:#{mins}"
  end
end
