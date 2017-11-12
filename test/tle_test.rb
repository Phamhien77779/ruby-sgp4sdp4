# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/*_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4sdp4"

class TestTest < MiniTest::Test
  include Sgp4sdp4

  def test_tle_from_string
    tle = Tle.new([
                    "1 88888U          80275.98708465  .00073094  13844-3  66816-4 0    87",
                    "2 88888  72.8435 115.9689 0086731  52.6988 110.5714 16.05824518  1058"
                  ])
    assert_equal 80_275.98708465, tle.epoch
    assert_equal 0.00073094, tle.xndt2o
    assert_equal 0.13844e-3, tle.xndd6o
    assert_equal 0.66816e-4, tle.bstar
    assert_equal 72.8435, tle.xincl
    assert_equal 0.0, tle.xnodeo
    assert_equal 0.0, tle.eo
    assert_equal 0.0, tle.omegao
    assert_equal 110.5714, tle.xmo
    assert_equal 16.05824518, tle.xno
    assert_equal 88_888, tle.norad_number
    assert_equal 0, tle.bulletin_number
    assert_equal 105, tle.revolution_number
    assert_equal "U", tle.classification
    assert_equal "", ephemeris_type
    assert_equal "", intl_desig
  end

  def test_goes9_tle_from_string
    tle = Tle.new([
                    "1 23581U 95025A   01311.43599209 -.00000094  00000-0  00000+0 0  8214",
                    "2 23581   1.1236  93.7945 0005741 214.4722 151.5103  1.00270260 23672"
                  ])
    assert_equal 1_311.43599209, tle.epoch
    assert_equal(-0.00000094, tle.xndt2o)
    assert_equal 0.00000e-0, tle.xndd6o
    assert_equal 0.00000e+0, tle.bstar
    assert_equal 1.1236, tle.xincl
    assert_equal 0.0, tle.xnodeo
    assert_equal 0.0, tle.eo
    assert_equal 0.0, tle.omegao
    assert_equal 151.5103, tle.xmo
    assert_equal 1.00270260, tle.xno
    assert_equal 23_581, tle.norad_number
    assert_equal 0, tle.bulletin_number
    assert_equal 2367, tle.revolution_number
    assert_equal "U", tle.classification
    assert_equal "", ephemeris_type
    assert_equal "", intl_desig
  end
end
