# frozen_string_literal: true

module Sgp4
  # Epemeris is the result of a propagation of the satellite's orbit.
  class Ephemeris
    # Normallly you won't call this.
    # An object of class Ephermis is returned by {Sgp4::calculate}.
    # You may initialize one yourself when writing test code.
    def initialize(t, pos, vel, semilatus_rectum = nil, semimajor_axis, eccentricity)
      @t = t
      @pos = pos
      @vel = vel
      @semimajor_axis = semimajor_axis
      @semilatus_rectum = semilatus_rectum
      @eccentricity = eccentricity
    end

    # @return [Float] the eccentricity of the orbit.
    # A measure of elliptical the orbit is.
    attr_reader :eccentricity
    alias ecc eccentricity

    # @return [Float] the position of the satellite
    #   at time t, in kilometres.
    attr_reader :pos

    # @return [Coordinates] TBD.
    attr_reader :semilatus_rectum
    alias p semilatus_rectum

    # @return [Coordinates] TBD.
    attr_reader :semimajor_axis
    alias a semimajor_axis

    # @return [DateTime] The time of the ephemeris, in UTC.
    attr_reader :t
    # @return [Coordinates] the velocity of the satellite
    #   at time t,
    #   in kilometres per second.
    attr_reader :vel
  end
end
