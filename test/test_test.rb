# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/*_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4sdp4"

class TestTest < MiniTest::Test
  %w[sgp sgp4 sgp8 sdp4 sdp8].each do |ephemeris|
    delta = 360
    0.upto(1440 / delta).map { |i| i * delta }.each do |since|
      define_method("test_#{ephemeris}_#{since}") do
        # Works because my names are ASCII
        Module.const_get("Sgp4sdp4::" + ephemeris.capitalize).new
      end
    end
  end
end
