require 'rails_helper'

feature "movie notification", type: :feature do
  scenario "user recieves option to create movie notification" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    movie_nil_name = "A bad Movie"

    allow_any_instance_of(DataRetriever).to receive(:get_data) { itunes_response }
    allow_any_instance_of(SearchResult).to receive(:no_results?) { true }
    fill_in "Search", with: movie_nil_name
    click_button "Search"
    click_button "Notify"

    expect(page).to have_text "Your Notifications"
    expect(page).to have_text movie_nil_name
  end
end
