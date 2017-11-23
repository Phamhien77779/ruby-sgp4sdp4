module Sgp4
  class Sgp4
    def initialize(tle)
      @tle = tle.is_a?(Tle) ? tle : Tle.new(tle)
    end

    def to_s
      puts "#{pos} #{vel}"
    end

    attr_reader :tle, :pos, :vel
  end
end
