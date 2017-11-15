# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/*_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4sdp4"

class TestTest < MiniTest::Test
  include Sgp4sdp4

  def initialize(arg)
    super
    @satellites = {
      fake_1: Tle.new([
                        "1 88888U          80275.98708465  .00073094  13844-3  66816-4 0    87",
                        "2 88888  72.8435 115.9689 0086731  52.6988 110.5714 16.05824518  1058"
                      ]),
      fake_2: Tle.new([
                        "1 11801U          80230.29629788  .01431103  00000-0  14311-1       2",
                        "2 11801U 46.7916 230.4354 7318036  47.4722  10.4117  2.28537848     2"
                      ]),
      goes_9: Tle.new([
                        "1 23581U 95025A   01311.43599209 -.00000094  00000-0  00000+0 0  8214",
                        "2 23581   1.1236  93.7945 0005741 214.4722 151.5103  1.00270260 23672"
                      ]),
      cosmos_1191: Tle.new([
                             "1 11871U 80057A   01309.36911127 -.00000499 +00000-0 +10000-3 0 08380",
                             "2 11871 067.5731 001.8936 6344778 181.9632 173.2224 02.00993562062886"
                           ]),
      esa_goes_1: Tle.new([
                            "1 09931U 77029A   01309.17453186 -.00000329 +00000-0 +10000-3 0 05967",
                            "2 09931 026.4846 264.1300 6609654 082.2734 342.9061 01.96179522175451"
                          ]),
      cosmos_1217: Tle.new([
                             "1 12032U 80085A   01309.42683181  .00000182  00000-0  10000-3 0  3499",
                             "2 12032  65.2329  86.7607 7086222 172.0967 212.4632  2.00879501101699"
                           ]),
      molniya_3_19Rk: Tle.new([
                                "1 13446U 82083E   01283.10818257  .00098407  45745-7  54864-3 0  6240",
                                "2 13446  62.1717  83.8458 7498877 273.9677 320.2568  2.06357523137203"
                              ]),
      ariane_deb: Tle.new([
                            "1 23246U 91015G   01311.70347086  .00004957  00000-0  43218-2 0  8190",
                            "2 23246   7.1648 263.6949 5661268 241.8299  50.5793  4.44333001129208"
                          ])
    }
  end

  # FIXME: Make the rest work when one is working.
  # %w[sgp sgp4 sgp8 sdp4 sdp8].each do |ephemeris|
  %w[sgp].each do |ephemeris|
    delta = 360
    0.upto(1440 / delta).map { |i| i * delta }.each do |since|
      define_method("test_#{ephemeris}_#{since}") do
        # Works because my names are ASCII
        @satellites.each_pair do |satellite, tle|
          propagator = Module.const_get("Sgp4sdp4::" + ephemeris.capitalize).new(tle)
          puts "#{satellite}: #{propagator.calculate(since)}"
        end
      end
    end
  end
end
