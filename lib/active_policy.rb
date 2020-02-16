require "active_policy/version"
require 'active_policy/railtie' if defined?(Rails)
require 'active_policy/base'

module ActivePolicy
  class Error < StandardError; end
  # Your code goes here...
end
