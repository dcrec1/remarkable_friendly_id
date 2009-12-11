# encoding: utf-8
require 'rubygems'

RAILS_VERSION       = ENV['RAILS_VERSION']       || '2.3.5'

gem 'activesupport', RAILS_VERSION
require 'active_support'

gem 'activerecord', RAILS_VERSION
require 'active_record'

require 'friendly_id'

# Configure ActiveRecord connection
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => ':memory:'
)

# Load Remarkable FriendlyId on place to avoid gem to be loaded
dir = File.dirname(__FILE__)
require File.join(dir, 'model_builder')
require File.join(dir, '..', 'lib', 'remarkable_friendly_id')

# Include matchers
Remarkable.include_matchers!(Remarkable::FriendlyId, Spec::Example::ExampleGroup)
