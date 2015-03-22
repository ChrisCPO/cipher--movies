ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'factory_girl_rails'
require "helpers/helpers"

RSpec.configure do |config|
  config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
