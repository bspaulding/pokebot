require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'logger'

class PokeBot
  include Capybara::DSL

  def initialize(options = {})
    Capybara.default_driver = :webkit
    Capybara.app_host = 'http://www.facebook.com'
    Capybara.run_server = false

    @logger = options[:logger] || Logger.new(STDOUT)
  end

  def log_in(args = {})
    say "logging in..."
    visit('/')
    fill_in "email", :with => args[:email]
    fill_in "pass",  :with => args[:password]
    click_on "Log In"
    say "logged in..."
  end

  def go_to_war
    visit('/pokes')
    while true
      say "waking up"
      if has_content? "Poke Back"
        click_link "Poke Back"
        say "poked somebody"
      else
        say "nobody to poke"
      end
      say "ok, sleeping"
      sleep 5
    end
  end

private
  def say(message, level = :info)
    @logger.send(level, "[pokebot] #{message}")
  end
end