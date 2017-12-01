module Sgp4
  # A propagator for near-earth and deep-space satellites.
  class Sgp4
    # @!method calculate(since)
    # Calculate the position and velocity of a satellite at a time since
    # the time of the observation of the two-line element.
    # {since} can be positive or negative.
    # In general, the smaller the absolute value of since,
    # the more accurate the propagation.
    # Put another way,
    # future predictions will be most accurate
    # if you use the most up-to-date two-line elements you can find.
    #
    # The calculation is done based on either the SGP4 mathematical model
    # or the SDP4 mathematical model. SGP4 is for near-earth satellites.
    # SDP4 is for deep space satellites.
    # The initialization of the propagator determines
    # which mathematical model to use
    # based on the two-line elements.
    # @param since [Float] time in minutes since the two-line element
    #   was observed (the "epoch").

    # Initialize an SGP4/SDP4 propagator for a given two-line element.
    # This includes determining whether to use the near-earth model SGP4,
    # or the deep space model SDP4.
    # @param tle [Array, Tle] an array of two strings in two-line element
    #   format, or an already initialize Tle object.
    def initialize(tle)
      @tle = tle.is_a?(Tle) ? tle : Tle.new(tle)
    end

    # @return [String] a convenient string representation of the position
    #   and velocity of the satellite.
    def to_s
      puts "#{pos} #{vel}"
    end

    # @nodoc
    attr_reader :tle

    # @return [Coordinates] the position of the satellite
    #   after {#calculate} has been called, in kilometres.
    attr_reader :pos

    # @return [Coordinates] the velocity of the satellite
    #   after {#calculate} has been called,
    #   in kilometres per second.
    attr_reader :vel
  end
end
