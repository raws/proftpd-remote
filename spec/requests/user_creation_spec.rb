require 'sinatra_helper'

describe 'Creating a ProFTPD user' do
  let(:params) do
    { name: 'foo', password: 's3cr3t' }
  end

  context 'with incorrect credentials' do
    before do
      post '/users', params
    end

    it 'should respond with HTTP 401 Unauthorized' do
      expect(last_response).to be_unauthorized
    end
  end

  context 'when user creation fails' do
    before do
      user_double = instance_double('User', create: false)
      allow(User).to receive(:new).and_return(user_double)

      set_authentication_header
      post '/users', params
    end

    it 'should respond with HTTP 400 Bad Request' do
      expect(last_response).to be_bad_request
    end
  end

  context 'when user creation succeeds' do
    before do
      user_double = instance_double('User', create: true)
      allow(User).to receive(:new).and_return(user_double)

      set_authentication_header
      post '/users', params
    end

    it 'should respond with HTTP 201 Created' do
      expect(last_response).to be_created
    end
  end
end
