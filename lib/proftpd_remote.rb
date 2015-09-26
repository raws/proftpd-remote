require 'sinatra'

require 'models/settings'
require 'models/user'

class ProFtpdRemote < Sinatra::Base
  enable :logging

  delete '/users' do
    if User.new(params[:name]).destroy
      200
    else
      400
    end
  end

  post '/users' do
    if User.new(params[:name], params[:password]).create
      201
    else
      400
    end
  end
end
