#! /usr/bin/env ruby

unless ENV["FACEBOOK_EMAIL"] && ENV["FACEBOOK_PASSWORD"]
  puts "Facebook Account Info is required, please supply FACEBOOK_EMAIL and FACEBOOK_PASSWORD"
  exit 1
end

require_relative "./poke_bot.rb"
require 'logger'

pokebot = PokeBot.new :logger => Logger.new('pokebot.log')
pokebot.log_in :email => ENV["FACEBOOK_EMAIL"], :password => ENV["FACEBOOK_PASSWORD"]
pokebot.go_to_war
