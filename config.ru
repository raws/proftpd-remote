$: << File.join(File.dirname(__FILE__), 'lib')
$: << File.join(File.dirname(__FILE__), 'config')

require 'environment'
require 'proftpd_remote'

run ProFtpdRemote.new
