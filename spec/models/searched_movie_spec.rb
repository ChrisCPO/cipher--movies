require "rails_helper"

describe SearchedMovie do
  describe ".title" do
    it "returns title" do
      movie = SearchedMovie.new(movie_in_test_response)

      expect(movie.title).to eq "Antz"
    end
  end

  describe ".apple_id" do
    it "returns apples id" do
      movie = SearchedMovie.new(movie_in_test_response)

      expect(movie.apple_id).to eq 909728081
    end
  end

  describe ".release_date" do
    it "returns release date" do
      movie = SearchedMovie.new(movie_in_test_response)

      expect(movie.release_date).to eq "Mar 23 1999"
    end
  end

  describe ".image_large" do
    it "returs large image url" do
      movie = SearchedMovie.new(movie_in_test_response)
      url = "http://is1.mzstatic.com/image/pf/us/r30/Video1/v4/17/16/51/17165137-11a4-6249-9616-7a1518eb5982/mza_2462674358740247802.100x100-75.jpg"

      expect(movie.image_large).to eq url
    end
  end

  describe ".apple_url" do
    it "returs apple page url" do
      movie = SearchedMovie.new(movie_in_test_response)
      url = "https://itunes.apple.com/us/movie/antz/id909728081?uo=4"

      expect(movie.apple_url).to eq url
    end
  end

  describe ".content_advisory_rating" do
    it "returns rating" do
      movie = SearchedMovie.new(movie_in_test_response)
      rating = "PG"

      expect(movie.content_advisory_rating).to eq rating
    end
  end

  describe ".long_description" do
    it "returns long description" do
      movie = SearchedMovie.new(movie_in_test_response)
      description = "A small worker ant named Z dreams of winning the heart of the beautiful Princess Bala so he convinces his soldier ant buddy to switch places with him.  Once the most insignificant of workers, Z may turn out to be the biggest little hero of them all!  With a superstar cast including Sharon Stone, Gene Hackman, Sylvester Stallone and Woody Allen, everyone will dig this spectacular comedy adventure."

      expect(movie.long_description).to eq description
    end
  end

  describe ".shot_description" do
    it "returns shot description" do
      movie = SearchedMovie.new(movie_in_test_response)
      description = "From the Academy Award - winning studio that brought you Shrek, DreamWorks' spectacular comedy"

      expect(movie.short_description).to eq description
    end
  end

  describe ".genre" do
    it "returns genra" do
      movie = SearchedMovie.new(movie_in_test_response)
      genre = "Kids & Family"

      expect(movie.genre).to eq genre
    end
  end

  describe ".length" do
    it "returns movie length in hours seconds" do
      movie = SearchedMovie.new(movie_in_test_response)
      time = "1:23"

      expect(movie.length).to eq time
    end
  end
end
