require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.register_driver :appium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.new({
    platformName: 'Android',
    browserName: 'Browser',
    'appium:automationName': 'UiAutomator2',
    'appium:deviceName': ENV['DEVICE_NAME'] || '0084665686',
    'appium:chromedriverExecutable': '/usr/bin/chromedriver'
  })

  Capybara::Selenium::Driver.new(app,
    browser: :remote,
    url: ENV['SELENIUM_REMOTE_URL'] || 'http://appium-node-1:4723/',
    capabilities: caps
  )
end

Capybara.default_driver = :appium
Capybara.javascript_driver = :appium
Capybara.default_max_wait_time = 30
