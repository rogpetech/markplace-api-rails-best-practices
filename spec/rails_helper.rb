# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'shoulda/matchers'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

rails_support_path = Rails.root.join('spec', 'support', '**', '*.rb')
Dir[rails_support_path].each { |file| require file }

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts 'required simplecov'
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  # config.use_active_record = false

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  config.include Request::JsonHelpers, type: :controller
  config.include Request::HeadersHelpers, type: :controller
  config.before(:each, type: :controller) do
    include_default_accpet_headers
  end
  config.before(:each, type: :request) do |example|
    host! 'api.example.com'
  end
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
