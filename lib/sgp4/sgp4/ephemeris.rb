# frozen_string_literal: true

module Sgp4
  # Epemeris is the result of a propagation of the satellite's orbit.
  class Ephemeris
    # Normallly you won't call this.
    # An object of class Ephermis is returned by {Sgp4::calculate}.
    # You may initialize one yourself when writing test code.
    def initialize(t,
      pos,
      vel,
      semilatus_rectum,
      semimajor_axis,
      eccentricity,
      inclination,
      longitude_of_ascending_node,
      argument_of_perigee,
      true_anomaly,
      mean_anomaly)
      @t = t
      @pos = pos
      @vel = vel
      @semimajor_axis = semimajor_axis
      @semilatus_rectum = semilatus_rectum
      @eccentricity = eccentricity
      @inclination = inclination
      @longitude_of_ascending_node = longitude_of_ascending_node
      @argument_of_perigee = argument_of_perigee
      @true_anomaly = true_anomaly
      @mean_anomaly = mean_anomaly
    end

    # @return [Float] the argument of perigee of the orbit in radians.
    attr_reader :argument_of_perigee
    alias argp argument_of_perigee

    # @return [Float] the eccentricity of the orbit.
    # A measure of elliptical the orbit is.
    attr_reader :eccentricity
    alias ecc eccentricity

    # @return [Float] the inclination of the orbit in radians.
    attr_reader :inclination
    alias incl inclination

    # @return [Float] the longitude of ascending node of the orbit in radians.
    attr_reader :longitude_of_ascending_node
    alias omega longitude_of_ascending_node

    # @return [Float] the mean anomaly in radians.
    attr_reader :mean_anomaly
    alias m mean_anomaly

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

    # @return [Float] the true anomaly in radians.
    attr_reader :true_anomaly
    alias nu true_anomaly
  end
end
