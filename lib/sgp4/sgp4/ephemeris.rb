module Sgp4
  # Epemeris is the result of a propagation of the satellite's orbit.
  class Ephemeris
    # Normallly you won't call this.
    # An object of class Ephermis is returned by {Sgp4::calculate}.
    # You may initialize one yourself when writing test code.
    def initialize(t = nil, pos = nil)
      @t = t
      @pos = pos
    end

    # @return [Coordinates] the position of the satellite
    #   at time t, in kilometres.
    attr_reader :pos
    # @return [DateTime] The time of the ephemeris, in UTC.
    attr_reader :t
  end
end
