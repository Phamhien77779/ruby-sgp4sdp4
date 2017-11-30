# frozen_string_literal: true

module Sgp4
  # x, y, and z values. "Coordinates" is a bit of a misnomer,
  # as the values can be position or velocity.
  class Coordinates
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    # @return [String] a convenient string representation of the coordinates.
    def to_s
      "#{x} #{y} #{z}"
    end

    # @return [Float] x value.
    attr_reader :x
    # @return [Float] y value.
    attr_reader :y
    # @return [Float] z value.
    attr_reader :z
  end
end
