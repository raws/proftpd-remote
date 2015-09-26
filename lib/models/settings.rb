class Settings < Settingslogic
  source File.join(File.dirname(__FILE__), '../../config/settings.yml')
  namespace ENV['RACK_ENV'] || 'development'
end
