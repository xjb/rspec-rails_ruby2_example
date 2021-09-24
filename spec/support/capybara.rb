require 'selenium-webdriver'

Capybara.configure do |config|
end

Capybara.register_driver :remote_chrome do |app|
  args = [
    'no-sandbox',
    'headless',
    'disable-gpu',
    'window-size=1680,1050'
  ]
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => args
    }
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV['SELENIUM_HUB_URL'],
    desired_capabilities: caps
  )
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.app_host = "http://#{Capybara.server_host}"
    driven_by :remote_chrome
  end
end