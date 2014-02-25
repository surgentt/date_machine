require 'selenium-webdriver'
require 'capybara'

session = if ARGV[0] != 'phantomjs'
  Capybara::Session.new(:selenium)
# else
#   require 'capybara/poltergeist'
#   Capybara::Session.new(:poltergeist)
# end

session.visit "http://www.okcupid.com/home"

if session.has_content?("Welcome!")
  puts "All shiny, captain!"
else
  puts ":( no tagline fonud, possibly something's broken"
  exit(-1)
end