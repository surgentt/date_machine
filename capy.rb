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
    session.visit "http://www.okcupid.com/messages"
    all_messages = Nokogiri::HTML(session.html)
    all_messages.css("a.open span.subject").collect { |i| i.text }
  end

  def message_urls
    session.visit "http://www.okcupid.com/messages"
    messages_index = Nokogiri::HTML(session.html)
    messages_index.css(".thread.message.readMessage a.open").collect { |l| l.attribute('href').value}
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
puts "SENDERS: #{profile.senders}"
puts "MESAAGE URLS #{profile.message_urls}"

binding.pry



