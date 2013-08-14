ENV['RAILS_ENV'] = 'test'

puts "Testing Rails v#{Rails.version}"

# add dummy to the load path. now we're also at the root of the fake rails app.
app_path = File.expand_path("../dummy",  __FILE__)
$LOAD_PATH.unshift(app_path) unless $LOAD_PATH.include?(app_path)

# if require rails, get uninitialized constant ActionView::Template::Handlers::ERB::ENCODING_FLAG (NameError)
require 'rails/all'
require 'config/environment'
require 'db/schema' unless ActiveRecord::Base.connection.table_exists?(:foos)
require 'rails/test_help'
require 'rspec/rails'
require 'otw'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.mock_with :rspec
  config.order = :random
  # Make sure this is not set to true, or cannot test concurrency
  config.use_transactional_fixtures = false
end
