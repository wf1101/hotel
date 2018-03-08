require 'simplecov'
SimpleCov.start do
  add_filter "/specs/"
end
require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/admin'
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/block'
