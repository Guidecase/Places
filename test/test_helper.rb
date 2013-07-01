require 'ansi/code'
require 'turn'
require 'minitest/autorun'
require_relative '../lib/places'

Mongoid.configure do |config|
  config.connect_to 'test-places'
end

class MiniTest::Unit::TestCase
  def teardown
    Mongoid.default_session.collections.each do |collection|
      collection.drop unless collection.name =~ /^system\./
    end
  end
end