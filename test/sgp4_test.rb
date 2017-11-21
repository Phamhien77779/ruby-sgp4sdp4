# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/sgp4_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4"

class TestTest < MiniTest::Test
  include Sgp4

  def test_tle_from_string
    tle = Tle.new([
                    "1 88888U          80275.98708465  .00073094  13844-3  66816-4 0    87",
                    "2 88888  72.8435 115.9689 0086731  52.6988 110.5714 16.05824518  1058"
                  ])
    assert_equal "U", tle.classification, "classification wrong"
    assert_equal 8, tle.bulletin_number, "bulletin_number wrong"
    assert_equal 88_888, tle.norad_number, "norad_number wrong"
    assert_equal "        ", tle.intl_desig, "intl_desig wrong"
    assert_equal "0", tle.ephemeris_type, "ephemeris_type wrong"
    assert_equal 105, tle.revolution_number, "revolution_number wrong"
    # All the rest are somehow calculated inside parse_elements, e.g.
    # units changed or what have you.
    assert_equal 2.2148107004387762e-09, tle.xndt2o, "xndt2o wrong"
    assert_equal 2.9130905387501816e-13, tle.xndd6o, "xndd6o wrong"
    assert_in_epsilon 0.66816e-4, tle.bstar, 1e-8, "bstar wrong"
    assert_equal 1.2713589136764896, tle.xincl, "xincl wrong"
    assert_equal 2.0240391349160523, tle.xnodeo, "xnodeo wrong"
    assert_equal 0.0086731, tle.eo, "eo wrong"
    assert_equal 0.9197675718499878, tle.omegao, "omegao wrong"
    assert_equal 1.9298349885396582, tle.xmo, "xmo wrong"
    assert_equal 0.07006731262087737, tle.xno, "xno wrong"
    assert_equal 2444514.48708465, tle.epoch, "epoch wrong"
  end

  def test_goes9_tle_from_string
    tle = Tle.new([
                    "1 23581U 95025A   01311.43599209 -.00000094  00000-0  00000+0 0  8214",
                    "2 23581   1.1236  93.7945 0005741 214.4722 151.5103  1.00270260 23672"
                  ])
    assert_equal "U", tle.classification, "classification wrong"
    assert_equal 821, tle.bulletin_number, "bulletin_number wrong"
    assert_equal 23_581, tle.norad_number, "norad_number wrong"
    assert_equal "95025A  ", tle.intl_desig, "intl_desig wrong"
    assert_equal "0", tle.ephemeris_type, "ephemeris_type wrong"
    assert_equal 2367, tle.revolution_number, "revolution_number wrong"
    # All the rest are somehow calculated inside parse_elements, e.g.
    # units changed or what have you.
    assert_equal(-2.8482803765185237e-12, tle.xndt2o, "xndt2o wrong")
    assert_equal 0.00000e-0, tle.xndd6o, "xndd6o wrong"
    assert_in_epsilon 0.00000e+0, tle.bstar, 1e-8, "bstar wrong"
    assert_equal 0.01961051947540829, tle.xincl, "xincl wrong"
    assert_equal 1.6370228452618214, tle.xnodeo, "xnodeo wrong"
    assert_equal 0.0005741, tle.eo, "eo wrong"
    assert_equal 3.7432460439957826, tle.omegao, "omegao wrong"
    assert_equal 2.6443535856843647, tle.xmo, "xmo wrong"
    assert_equal 0.004375115447076924, tle.xno, "xno wrong"
    assert_equal 2452220.93599209, tle.epoch, "epoch wrong"
  end
end
