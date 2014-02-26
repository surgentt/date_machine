ENV["OKCUPID_ENV"] = "development"

require_relative '../config/environment'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/profiles-dev.db')

session = Capybara::Session.new(:selenium)
interact_session = OkcupidDriver.new(session)

interact_session.login

interact_session.quickmatch_like_people
interact_session.add_liked_to_profile_array