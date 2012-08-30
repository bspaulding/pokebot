#! /usr/bin/env ruby

unless ENV["FACEBOOK_EMAIL"] && ENV["FACEBOOK_PASSWORD"]
  puts "Facebook Account Info is required, please supply FACEBOOK_EMAIL and FACEBOOK_PASSWORD"
  exit 1
end

require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

include Capybara::DSL

Capybara.default_driver = :webkit
Capybara.app_host = 'http://www.facebook.com'
Capybara.run_server = false

puts "[poke-bot] logging in..."
visit('/')
fill_in "email", :with => ENV["FACEBOOK_EMAIL"]
fill_in "pass",  :with => ENV["FACEBOOK_PASSWORD"]
click_on "Log In"

puts "[poke-bot] logged in..."
visit('/pokes')
while true
  puts "[poke-bot] waking up"
  if has_content? "Poke Back"
    click_link "Poke Back"
    puts "[poke-bot] poked somebody"
  else
    puts "[poke-bot] nobody to poke"
  end
  puts "[poke-bot] ok, sleeping"
  sleep 5
end
