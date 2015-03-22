# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'capybara/rspec'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end

  config.order = :random
end
