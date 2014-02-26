require 'bundler/setup'
Bundler.require

require 'selenium-webdriver'
require 'capybara'
require 'pry'
require 'nokogiri'
## Can I remove the active_record
require "active_record"
require "sqlite3"
require "rspec"
require "pry"
# What does ostruct do
require 'ostruct'
require 'rake'

# This requires all information in the lib and model directory
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

DBRegistry[ENV["OKCUPID_ENV"]].connect!

DB = ActiveRecord::Base.connection

if ENV["OKCUPID_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

RAKE_APP ||= begin
  app = Rake.application
  app.init
  app.load_rakefile
  app
end