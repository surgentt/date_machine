class UserDriver

  attr_reader :session


  def initialize(session)
    @session = session
  end

  def login(username, password)    
    session.visit "http://www.okcupid.com/home"
    session.fill_in "user", :with => username
    sleep 1
    session.fill_in "pass", :with => password
    session.within "#login_form" do
      session.click_link "Sign in"
    end
  end


end