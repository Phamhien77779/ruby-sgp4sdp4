# frozen_string_literal: true

module Sgp4sdp4
  class Ephemeris
    def initialize(tle)
      @tle = tle.is_a?(Tle) ? tle : Tle.new(tle)
    end

    def to_s
      puts "pos: #{pos} vel: #{vel}"
    end

    attr_reader :tle, :pos, :vel
  end
end
