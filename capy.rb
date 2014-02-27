require 'selenium-webdriver'
require 'capybara'
require 'pry'
require 'nokogiri'




class Okcupid

  attr_reader :session

  def initialize(session)
    @session = session
    @name_array = [] # move to database
  end

  def nokogiri_doc(url)
    session.visit "http://www.okcupid.com/#{url}"
    doc = Nokogiri::HTML(session.html)
    # binding.pry
    doc
  end

  def login    
    session.visit "http://www.okcupid.com/home"
    session.fill_in "user", :with => "FlambeToe"
    session.fill_in "pass", :with => "12flambetoe34"
    session.within "#login_form" do
      session.click_link "Sign in"
    end
  end

  def send_message
    url = session.visit("http://www.okcupid.com/profile/#{username}?cf=profile")
  end

  def senders
    nokogiri_doc("messages").css("a.open span.subject").collect { |i| i.text }
  end

  def message_urls
    nokogiri_doc("messages").css(".thread.message a.open").collect do |link|
      link.attribute('href').value
    end
  end

  def message_content(arr_index)
    nokogiri_doc(message_urls[arr_index][1..-1]).css(".message_body").text
  end

  def message_response(arr_i_or_name, response)
    arr_i_or_name = sender_finder(arr_i_or_name) unless arr_i_or_name.is_a? Integer
    session.visit("http://www.okcupid.com/#{message_urls[arr_i_or_name][1..-1]}")
    session.fill_in('message_text', :with => "#{response}")
    session.click_button("#send") # DEBUG - cannot assign ID of button
  end

  def sender_finder(sender)
    senders.index(sender)
  end


  #def inbox # make inbox class
  #   session.visit "http://www.okcupid.com/messages"
  #   messages_index = Nokogiri::HTML(session.html)
  #   senders_arr = messages_index.css("a.open span.subject").collect { |i| i.text }
  #   binding.pry
  # end



  # def message
  #   @name_array.each do |username|
  #     # sleep 1
  #     session.visit("http://www.okcupid.com/profile/#{username}?cf=profile")
  #     # session.click_on("Send a Message")
  #     # sleep 3
  #     # session.fill_in('message_text', :with => "Do you like Capybara's? There my favorite. I work at a zoo. :)")
  #     # sleep 1
  #     # session.click_button("send_btn")
  #   end
  # end
  
end

session = Capybara::Session.new(:selenium)
profile = Okcupid.new(session)
profile.login
puts "SENDERS: #{profile.senders.size}"
puts "MESSAGE URLS #{profile.message_urls.size}"
him = profile.sender_finder("mob_fleet")
puts "#{profile.senders[him]} wrote #{profile.message_content(him)}"
profile.message_response(him, "Hiiiii how are you?")

binding.pry



