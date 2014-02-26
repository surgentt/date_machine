ENV["OKCUPID_ENV"] = "development"

require_relative '../config/environment'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/profiles-dev.db')

session = Capybara::Session.new(:selenium)
profile = Profile.new(session)

profile.login