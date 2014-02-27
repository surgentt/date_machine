class OkcupidDriver

  attr_accessor :profiles, :profile, :unmessaged_profiles, :unmessaged_arr, :unmessaged_profile
  attr_reader :session

  def initialize(session)
    @session = session
    @profiles = []
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
    sleep 3
  end

  def quickmatch_like_people
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

  def save_profile
    profile = Profile.create(:username => profile, :messaged => 0)
  end

  def add_liked_to_profile_array
    session.visit "http://www.okcupid.com/who-you-like?show_min_personality=3"
    liked_doc = Nokogiri::HTML(session.html)
    profiles << liked_doc.css("a.name").map(&:text)
    profiles.flatten!
    save_profiles_to_db
  end

  def save_profiles_to_db
    profiles.each do |username|
      profile = Profile.create(:username => username, :messaged => 0)
    end
  end

  def get_unmessaged_profiles_from_db
    self.unmessaged_profiles = Profile.where("messaged = 0").limit(5)
  end

  def message
    self.unmessaged_profiles.each do |unmessaged_profile|
      sleep 1
      session.visit("http://www.okcupid.com/profile/#{unmessaged_profile.username}?cf=profile")
      session.click_on("Send a Message")
      sleep 1
      # Rescue method if name is not there
      if session.has_selector?('textarea#message_text')
        session.fill_in('message_text', :with => "Do you like Capybara's? There my favorite. :)")
        sleep 2
        session.click_button("send_btn")
      end
      unmessaged_profile.update(:messaged => 1)
    end
  end
end