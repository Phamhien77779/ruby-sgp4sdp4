# frozen_string_literal: true

module Sgp4sdp4
  class Tle
    def initialize(tle); end

    attr_reader :epoch,
      :xndt2o,
      :xndd6o,
      :bstar,
      :xincl,
      :xnodeo,
      :eo,
      :omegao,
      :xmo,
      :xno,
      :norad_number,
      :bulletin_number,
      :revolution_number,
      :classification,
      :ephemeris_type,
      :intl_desig
  end
end
