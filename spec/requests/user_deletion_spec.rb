require 'sinatra_helper'

describe 'Deleting a ProFTPD user' do
  let(:params) do
    { name: 'foo' }
  end

  context 'with incorrect credentials' do
    before do
      delete '/users', params
    end

    it 'should respond with HTTP 401 Unauthorized' do
      expect(last_response).to be_unauthorized
    end
  end

  context 'when user deletion fails' do
    before do
      user_double = instance_double('User', destroy: false)
      allow(User).to receive(:new).and_return(user_double)

      set_authentication_header
      delete '/users', params
    end

    it 'should respond with HTTP 400 Bad Request' do
      expect(last_response).to be_bad_request
    end
  end

  context 'when user deletion succeeds' do
    before do
      user_double = instance_double('User', destroy: true)
      allow(User).to receive(:new).and_return(user_double)

      set_authentication_header
      delete '/users', params
    end

    it 'should respond with HTTP 200 OK' do
      expect(last_response).to be_ok
    end
  end
end
