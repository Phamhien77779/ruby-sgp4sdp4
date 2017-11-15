# frozen_string_literal: true

module Sgp4sdp4
  class Coordinates
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    def to_s
      "x: #{x} y: #{y} z: #{z}"
    end

    attr_reader :x, :y, :z
  end
end
