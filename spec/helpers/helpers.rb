require "spec_helper"

module Helpers
  def sign_in(user)
    visit "session/new"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"
  end

  def movie_in_test_response
    itunes_response[:results][0]
  end

  def itunes_response
    api_json_response.with_indifferent_access
  end

  def api_json_response
    VCR.use_cassette("Antz") do
      url = URI("https://itunes.apple.com/search?term=Antz&entity=movie")
      return JSON.parse(Net::HTTP.get(url))
    end
  end
end
