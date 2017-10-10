require "test_helper"
require "capybara/poltergeist"
require 'phantomjs'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :poltergeist, options: { phantomjs: Phantomjs.path }
end
