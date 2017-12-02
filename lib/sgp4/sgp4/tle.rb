# frozen_string_literal: true

module Sgp4
  class Tle
    attr_reader :epoch,
      :xndt2o,
      :bstar,
      :xincl,
      :xnodeo,
      :eo,
      :omegao,
      :xmo,
      :xno,
      :norad_number,
      :revolution_number

    # @return [Float] km ** 3 / s ** 2
    attr_reader :gravitational_parameter
    alias mu gravitational_parameter
  end
end
