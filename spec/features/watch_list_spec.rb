require 'rails_helper'

feature "Watch_List", type: :feature do
  scenario "user can view all movies in watch list" do
    user = FactoryGirl.create(:user)
    movie = FactoryGirl.create(:movie)
    sign_in(user)

    user.movies << movie
    allow_any_instance_of(DataRetriever).to receive(:get_data) { itunes_response }
    click_link "My Watch List"

    expect(page).to have_text movie.title
  end

  scenario "user can add a movie to there watch list" do
    user = FactoryGirl.create(:user)
    movie_apple_id = movie_in_test_response[:trackId]
    sign_in(user)

    allow_any_instance_of(DataRetriever).to receive(:get_data) { itunes_response }
    fill_in "Search", with: "Antz"
    click_button "Search"
    click_link "Antz"
    click_button "Add to My List"

    expect(user.movies[0].id).to eq movie_apple_id
  end
end
