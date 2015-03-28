require "rails_helper"

describe "Search" do
  scenario "user can search itunes for movies" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    allow_any_instance_of(DataRetriever).to receive(:get_data) {itunes_response}

    fill_in "Search", with: "Antz"
    click_button "Search"

    expect(page).to have_text "Antz"
  end

  scenario "user can visit searched movie path" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    movie_title = "Antz"

    allow_any_instance_of(DataRetriever).to receive(:get_data) {itunes_response}

    fill_in "Search", with: movie_title
    click_button "Search"
    click_link movie_title

    expect(page).to have_text movie_title
  end
end
