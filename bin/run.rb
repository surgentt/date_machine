ENV["OKCUPID_ENV"] = "development"

require_relative '../config/environment'

session = Capybara::Session.new(:selenium)
interact_session = OkcupidDriver.new(session)

interact_session.login

3.times do 
  interact_session.quickmatch_like_people
end

#interact_session.add_liked_to_profile_array