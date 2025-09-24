require 'capybara/cucumber'
require 'selenium-webdriver'

BROWSER = (ENV['BROWSER'] || 'chrome').to_sym

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: BROWSER)
end

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 10
