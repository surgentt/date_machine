ENV["OKCUPID_ENV"] = "development"

require_relative '../config/environment'

session = Capybara::Session.new(:selenium)
inbox = MessageDriver.new(session)
inbox.login("flambetoe", "12flambetoe34")

puts "SENDERS: #{inbox.senders.size}"
puts "MESSAGE URLS: #{inbox.message_urls.size}"

inbox.senders.each do |sender|
  @user = User.create(:username => sender)

  current_sender = inbox.sender_finder(sender)
  inbox.message_content(current_sender).each do |message_content|
  Message.create(
    :message_content => message_content,
    :sender_id => @user.id
    )
  end
end



# him = inbox.sender_finder("mob_fleet")
# puts "#{inbox.senders[him]} wrote #{inbox.message_content(him)}"
# inbox.message_response(him, "You don't seem to be very interested.")

# binding.pry
