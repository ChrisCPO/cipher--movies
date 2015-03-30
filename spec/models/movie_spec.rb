require 'rails_helper'

describe Movie, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:watch_lists) }
    it { is_expected.to have_many(:users).through(:watch_lists) }
  end
end
