require 'rails_helper'

RSpec.describe WatchList, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:user) }
  end
end
