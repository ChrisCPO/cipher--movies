require "rails_helper"

describe User do
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
end
