require "rails_helper"

describe DataRetriever do
  describe "rspec helper method" do
    it "returns body of request" do
      expect(itunes_response["resultCount"]).to eq 1
      expect(itunes_response[:resultCount]).to eq 1
    end
  end

  describe ".get_data" do
    it "returns hash with indifferent access" do
      data_retriever = DataRetriever.new
      answer = "ActiveSupport::HashWithIndifferentAccess"

      allow_any_instance_of(DataRetriever).to receive(:json_convert) do
        api_json_response
      end

      api_response = data_retriever.get_data("Antz")

      expect(api_response.class.to_s).to eq answer
    end

    it "returns hash with data when given movie name" do
      data_retriever = DataRetriever.new
      movie_name = "Antz"

      allow_any_instance_of(DataRetriever).to receive(:json_convert) do
        api_json_response
      end

      api_response = data_retriever.get_data(movie_name, search_by_id: false)

      expect(api_response[:results][0][:trackName]).to eq movie_name
    end

    it "returns correct url when given movie id" do
      data_retriever = DataRetriever.new
      movie_id = "909728081"
      answer = "https://itunes.apple.com/lookup?id=#{movie_id}"

      allow_any_instance_of(DataRetriever).to receive(:json_convert) do
        api_json_response
      end

      data_retriever.get_data(movie_id, search_by_id: true)
      data_retriever.send(:set_url)

      expect(data_retriever.url).to eq answer
    end

    it "removes spaces in word data" do
      data_retriever = DataRetriever.new
      search_info = " the Hobbit "
      answer = "https://itunes.apple.com/search?term=the+Hobbit&entity=movie"

      allow_any_instance_of(DataRetriever).to receive(:json_convert) do
        api_json_response
      end

      data_retriever.get_data(search_info)
      data_retriever.send(:set_url)

      expect(data_retriever.url).to eq answer
    end
  end
end
