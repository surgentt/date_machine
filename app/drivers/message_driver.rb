

class MessageDriver

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

  def login(username, password)    
    session.visit "http://www.okcupid.com/home"
    session.fill_in "user", :with => username
    sleep 1
    session.fill_in "pass", :with => password
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
    sender_finder(arr_i_or_name)
    # binding.pry
    session.visit("http://www.okcupid.com/#{message_urls[arr_i_or_name][1..-1]}")
    session.fill_in('message_text', :with => "#{response}")
    # binding.pry
    session.find('a[href="#send"]').click
  end

  def sender_finder(arr_i_or_name)
    arr_i_or_name = senders.index(arr_i_or_name) unless arr_i_or_name.is_a? Integer
  end

  #def inbox # make inbox class
  #   session.visit "http://www.okcupid.com/messages"
  #   messages_index = Nokogiri::HTML(session.html)
  #   senders_arr = messages_index.css("a.open span.subject").collect { |i| i.text }
  #   binding.pry
  # end

end

# binding.pry



