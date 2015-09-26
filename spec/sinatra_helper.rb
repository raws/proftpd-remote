require 'rack/test'
require_relative 'support/authentication_helper'

module AppHelper
  def app
    ProFtpdRemote
  end
end

RSpec.configure do |config|
  config.include AppHelper
  config.include AuthenticationHelper
  config.include Rack::Test::Methods
end
