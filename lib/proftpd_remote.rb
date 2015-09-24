require 'sinatra'

class ProFtpdRemote < Sinatra::Base
  enable :logging

  get '/' do
    'Hello world!'
  end
end
