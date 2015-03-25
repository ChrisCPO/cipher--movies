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

      allow_any_instance_of(DataRetriever).to receive(:json_convert) do
        api_json_response
      end

      api_response = data_retriever.get_data("Antz")

      expect(api_response["resultCount"]).to eq 1
      expect(api_response[:resultCount]).to eq 1
    end
  end
end
