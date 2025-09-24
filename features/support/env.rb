require 'capybara/cucumber'
require 'selenium-webdriver'

BROWSER = (ENV['BROWSER'] || 'chrome').to_sym

Capybara.register_driver :selenium_remote do |app|
  capabilities =
    case BROWSER
    when :firefox
      Selenium::WebDriver::Remote::Capabilities.firefox
    else
      Selenium::WebDriver::Remote::Capabilities.chrome
    end

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://localhost:4444/wd/hub',
    capabilities: capabilities
  )
end

Capybara.default_driver = :selenium_remote
Capybara.javascript_driver = :selenium_remote
Capybara.default_max_wait_time = 10
