# I think is is actually a controller

class Interact #Okcupd driver, Better naming

  attr_writer :profiles
  attr_reader :session
  #profiles are profiles of other users I want to interact with

  def initialize(session)
    @session = session
    @profiles = [] # move to database
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

  def like_5
    5.times do 
      like_people
    end
  end

  def add_liked_to_array_db
    session.visit "http://www.okcupid.com/who-you-like?show_min_personality=3"
    liked_doc = Nokogiri::HTML(session.html)
    # Are we writing
    profiles << liked_doc.css("a.name").map(&:text)
    profiles.flatten!
  end

  #Test this
  # This dependcy needs to be publicly exposed
  def save_users_to_db
    name_array.each do |username|
      profile = Profile.new(:username => username)
      profile.save
    end
  end

  #PUll people people out of db and save

  #Needs to pull things from db

  def message
    @name_array.each do |username|
      sleep 1
      session.visit("http://www.okcupid.com/profile/#{username}?cf=profile")
      session.click_on("Send a Message")
      sleep 3
      #check of existence fo box
      #If Text box exists complete this function
        session.fill_in('message_text', :with => "Do you like Capybara's? There my favorite. I work at a zoo. :)")
        sleep 1
        session.click_button("send_btn")
    end


    # Method Test that boolean had been check
  end

end