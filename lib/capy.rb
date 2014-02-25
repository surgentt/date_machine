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
    session.fill_in "user", :with => "Capybara_lover"
    sleep 1
    session.fill_in "pass", :with => "capybara"
    sleep 1
    session.within "#login_form" do
      session.click_link "Sign in"
    end
  end

  def like_people
    session.visit 'http://www.okcupid.com/quickmatch'
    quick_match_doc = Nokogiri::HTML(session.html)
    percentage = quick_match_doc.search("span.match strong.percent").text.gsub("%", "").to_i

    if percentage > 75
      sleep rand(1..3)
      session.click_link "5 star rating"
    else
      sleep rand(1..3)
      session.click_link "1 star rating"
    end
  end

  # Database method
  def liked?
    session.visit "http://www.okcupid.com/who-you-like?show_min_personality=3"
    liked_doc = Nokogiri::HTML(session.html)
    # Are we writing
    @name_array << liked_doc.css("a.name").map(&:text)
    @name_array.flatten!
  end

  def message
    @name_array.each do |username|
      sleep 1
      session.visit("http://www.okcupid.com/profile/#{username}?cf=profile")
      session.click_on("Send a Message")
      sleep 3
      #check of existence fo box
      # GO onto next element
        session.fill_in('message_text', :with => "Do you like Capybara's? There my favorite. I work at a zoo. :)")
        sleep 1
        session.click_button("send_btn")
    end
  end
  
  def self.like_5
    5.times do 
      like_people
    end
  end
end

session = Capybara::Session.new(:selenium)
profile = Okcupid.new(session)
profile.login
#profile.message




