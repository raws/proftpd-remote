module AuthenticationHelper
  private

  def set_authentication_header
    authorize 'test', 'test'
  end
end
