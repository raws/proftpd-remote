require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] || 'development'

$:.unshift File.expand_path('../../lib', __FILE__)

$stdout.sync = true
