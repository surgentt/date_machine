
require_relative '../../config/environment'

require_relative './profile'

class OkcScraper < ActiveRecord::Base
  attr_accessor :url

  def initialize(url)
    @url = url
    # http://www.okcupid.com/profile/Jade_Colette
  end

  def scrape
    page = Nokogiri::HTML(open(@url))
    username = page.css("#basic_info_sn").text
    gender = page.css("#ajax_gender").text
    matchscore = page.css("#percentages span.match").text.gsub(/\D/, "").to_i
    age = page.css("#ajax_age").text.to_i
    OkcScraper.save_profile(username, gender, matchscore, age)
  end

  def self.save_profile(username, gender, matchscore, age)
    p = Profile.new()
    p.user_name = username
    p.gender = gender
    p.matchscore = matchscore
    p.age = age
    p.save
  end
end

