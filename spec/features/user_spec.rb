require 'rails_helper'

feature "User", type:  :feature do

  scenario "can sign up" do
    user_name = "test user"
    user_email = "test@testing.com"
    user_password = "test_password"

    visit "users/new"
    fill_in "Name", with: user_name
    fill_in "Email", with: user_email
    fill_in "Password", with: user_password

    click_button "Sign Up"

    expect(page).to have_text user_name
    expect(page).to have_text user_email
  end

  scenario "invaild forms displays errors" do
    user_name = "test user"
    user_password = "test_password"
    error = "Email can't be blank"

    visit 'users/new'
    fill_in "Name", with: user_name
    fill_in "Password", with: user_password

    click_button "Sign Up"

    expect(page).to have_text error
  end

  scenario "user can sign out" do
    user = FactoryGirl.create(:user)

    sign_in(user)

    visit dashboard_path
    click_on "Sign Out"

    expect(page).to have_text "Sign Up"
  end

  scenario "user can sign in" do
    user = FactoryGirl.create(:user)

    sign_in(user)

    expect(page).to have_text user.email
    expect(page).to have_text user.name
  end
end
