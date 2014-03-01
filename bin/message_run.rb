ENV["OKCUPID_ENV"] = "development"

require_relative '../config/environment'

session = Capybara::Session.new(:selenium)
messages = MessageDriver.new(session)
messages.login("flambetoe", "12flambetoe34")

puts "SENDERS: #{messages.senders.size}"
puts "MESSAGE URLS: #{messages.message_urls.size}"

him = messages.sender_finder("mob_fleet")
puts "#{messages.senders[him]} wrote #{messages.message_content(him)}"
messages.message_response(him, "You don't seem to be very interested.")

binding.pry
