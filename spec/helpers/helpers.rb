module Helpers
  def sign_in(user)
    visit "session/new"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"
  end
end
