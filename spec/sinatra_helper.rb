require 'rack/test'

module AppHelper
  def app
    ProFtpdRemote
  end
end

RSpec.configure do |config|
  config.include AppHelper
  config.include Rack::Test::Methods
end
