# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

DateMachine::Application.load_tasks

require_relative 'app/models/okc_scraper'

desc "Scrapes basic profile data"
task :scrape => :environment do
  scraper = OkcScraper.new("http://www.okcupid.com/profile/Jade_Colette")
  scraper.scrape
end