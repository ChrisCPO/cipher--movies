require "rails_helper"

describe SearchResult do
  describe ".no_results?" do
    it "returns true it count is zero" do
      results = SearchResult.new(count: 0)

      expect(results.no_results?).to eq true
    end

    it "returns false it count is not zero" do
      results = SearchResult.new(count: 1)

      expect(results.no_results?).to eq false
    end
  end
end
