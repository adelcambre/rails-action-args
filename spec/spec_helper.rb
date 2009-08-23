$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'rack'
require 'action_controller'
require 'rails_action_args'
require 'spec'
require File.expand_path(File.join(File.dirname(__FILE__), "controllers", "action_args_controller"))

Spec::Runner.configure do |config|
end
