$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'bundler'
Bundler.setup
Bundler.require

require 'rails_action_args'
require File.expand_path(File.join(File.dirname(__FILE__), "controllers", "action_args_controller"))

Spec::Runner.configure do |config|
  config.include(Rack::Test::Methods)
end
