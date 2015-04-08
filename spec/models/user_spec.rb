require "rails_helper"

describe User do
  describe "relationships" do
    it { should have_many(:watch_lists) }
    it { should have_many(:movies).through(:watch_lists) }
    it { should have_many(:notifications) }
  end

  describe "validations" do

    it { should validate_presence_of :email }
    it { should validate_presence_of :name }

    context "for a new user" do
      it "should not be valid without a password" do
        user = FactoryGirl.build(:user, password: nil, password_confirmation: nil)
        expect(user).to_not be_valid
      end

      it "should be not be valid with a short password" do
        user = FactoryGirl.build(:user, password: "short", password_confirmation: "short")
        expect(user).to_not be_valid
      end

      it "should not be valid with a confirmation mismatch" do
        user = FactoryGirl.build(:user, password: "weather", password_confirmation: "whether")
        expect(user).to_not be_valid
      end
    end

    context "for an existing user" do

      let(:user) { FactoryGirl.create(:user) }

      it "should be valid with no changes" do
        expect(user).to be_valid
      end

      it "should not be valid with an empty password" do
        user.password = user.password_confirmation = ""
        expect(user).to_not be_valid
      end

      it "should be valid with a new (valid) password" do
        user.password = user.password_confirmation = "new password"
        expect(user).to be_valid
      end
    end
  end

  describe "token authentication" do

    context "for a user with no auth token" do

      let(:password) { "lemme in" }
      let(:user) { FactoryGirl.create(:user, password: password, auth_token: nil) }

      it "should generate and save a new token on successful authentication" do
        expect(user.auth_token).to be_nil
        user.authenticate(password)
        expect(user.auth_token).to be_present
      end

      it "should not generate and save a new token on failed authentication" do
        expect(user.auth_token).to be_nil
        user.authenticate "not the password"
        expect(user.auth_token).to be_nil
      end

      it "should return false when attempting to authenticate with a token" do
        expect(user.authenticate_with_token('nope')).to eq false
        expect(user.authenticate_with_token(nil)).to eq false
      end
    end

    context "for a user with an auth token" do

      let(:password) { "lemme in" }
      let(:user) { FactoryGirl.create(:user, password: password) }

      it "should not change the existing auth token on successful authentication" do
        original_token = user.auth_token
        expect(original_token).to be_present
        user.authenticate(password)
        expect(user.auth_token).to eq(original_token)
      end

      it "should not change the existing auth token on failed authentication" do
        original_token = user.auth_token
        expect(original_token).to be_present
        user.authenticate("not the password")
        expect(user.auth_token).to eq(original_token)
      end

      it "should destroy the auth token" do
        user.destroy_token!
        expect(user.auth_token).to be_nil
      end

      it "should return the user when successfully authenticated with a token" do
        expect(user.authenticate_with_token(user.auth_token)).to eq user
      end

      it "should return false when token authentication fails" do
        expect(user.authenticate_with_token('nope')).to eq false
      end
    end
  end

  describe ".add_movie" do
    it "should add a movie to a users collection" do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)

      user.add_movie(movie)

      expect(user.movies).to include movie
    end
  end

  describe ".add_movie" do
    it "returns true if user.movies includes movie" do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)

      user.movies << movie

      expect(user.has_movie?(movie)).to eq true
    end

    it "returns false if user.moves does not include movie" do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)

      expect(user.has_movie?(movie)).to eq false
    end

    it "returns true when comparing Movie to temp movie" do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)
      temp_movie = TemporaryMovie.new(movie_in_test_response)

      allow(temp_movie).to receive(:id) { movie.id }
      user.movies << movie

      expect(user.has_movie?(temp_movie)).to eq true
    end
  end

  describe ".add_notification" do
    it "adds a notification to users notifications" do
      user = FactoryGirl.create(:user)
      notification = FactoryGirl.create(:notification)

      user.add_notification(notification)

      expect(user.notifications).to include notification
    end
  end

  describe ".remove_notification" do
    it "deletes a users notification" do
      user = FactoryGirl.create(:user)
      notification = FactoryGirl.create(:notification)

      user.notifications << notification
      user.remove_notification(notification)

      expect(user.notifications.length).to eq 0
      expect(user.notifications).not_to include notification
    end
  end
end
