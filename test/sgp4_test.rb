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
    # assert_equal "U", tle.classification, "classification wrong"
    # assert_equal 8, tle.bulletin_number, "bulletin_number wrong"
    assert_equal 88_888, tle.norad_number, "norad_number wrong"
    # assert_equal "        ", tle.intl_desig, "intl_desig wrong"
    # assert_equal "0", tle.ephemeris_type, "ephemeris_type wrong"
    assert_equal 105, tle.revolution_number, "revolution_number wrong"
    # All the rest are somehow calculated inside parse_elements, e.g.
    # units changed or what have you.
    assert_equal 2.2148107004387762e-09, tle.xndt2o, "xndt2o wrong"
    # assert_equal 2.9130905387501816e-13, tle.xndd6o, "xndd6o wrong"
    assert_in_epsilon 0.66816e-4, tle.bstar, 1e-8, "bstar wrong"
    assert_equal 1.2713589136764896, tle.xincl, "xincl wrong"
    assert_equal 2.0240391349160523, tle.xnodeo, "xnodeo wrong"
    assert_equal 0.0086731, tle.eo, "eo wrong"
    assert_equal 0.9197675718499878, tle.omegao, "omegao wrong"
    assert_equal 1.9298349885396582, tle.xmo, "xmo wrong"
    assert_equal 0.07006731262087737, tle.xno, "xno wrong"
    # assert_equal 2444514.48708465, tle.epoch, "epoch wrong"
  end

  def test_goes9_tle_from_string
    tle = Tle.new([
                    "1 23581U 95025A   01311.43599209 -.00000094  00000-0  00000+0 0  8214",
                    "2 23581   1.1236  93.7945 0005741 214.4722 151.5103  1.00270260 23672"
                  ])
    # assert_equal "U", tle.classification, "classification wrong"
    # assert_equal 821, tle.bulletin_number, "bulletin_number wrong"
    assert_equal 23_581, tle.norad_number, "norad_number wrong"
    # assert_equal "95025A  ", tle.intl_desig, "intl_desig wrong"
    # assert_equal "0", tle.ephemeris_type, "ephemeris_type wrong"
    assert_equal 2367, tle.revolution_number, "revolution_number wrong"
    # All the rest are somehow calculated inside parse_elements, e.g.
    # units changed or what have you.
    assert_equal(-2.8482803765185237e-12, tle.xndt2o, "xndt2o wrong")
    # assert_equal 0.00000e-0, tle.xndd6o, "xndd6o wrong"
    assert_in_epsilon 0.00000e+0, tle.bstar, 1e-8, "bstar wrong"
    assert_equal 0.01961051947540829, tle.xincl, "xincl wrong"
    assert_equal 1.6370228452618214, tle.xnodeo, "xnodeo wrong"
    assert_equal 0.0005741, tle.eo, "eo wrong"
    assert_equal 3.7432460439957826, tle.omegao, "omegao wrong"
    assert_equal 2.6443535856843647, tle.xmo, "xmo wrong"
    assert_equal 0.004375115447076924, tle.xno, "xno wrong"
    # assert_equal 2452220.93599209, tle.epoch, "epoch wrong"
  end
  #
  # satellites = {
  #   fake_1: Tle.new([
  #                     "1 88888U          80275.98708465  .00073094  13844-3  66816-4 0    87",
  #                     "2 88888  72.8435 115.9689 0086731  52.6988 110.5714 16.05824518  1058"
  #                   ]),
  #   fake_2: Tle.new([
  #                     "1 11801U          80230.29629788  .01431103  00000-0  14311-1       2",
  #                     "2 11801U 46.7916 230.4354 7318036  47.4722  10.4117  2.28537848     2"
  #                   ]),
  #   goes_9: Tle.new([
  #                     "1 23581U 95025A   01311.43599209 -.00000094  00000-0  00000+0 0  8214",
  #                     "2 23581   1.1236  93.7945 0005741 214.4722 151.5103  1.00270260 23672"
  #                   ]),
  #   cosmos_1191: Tle.new([
  #                          "1 11871U 80057A   01309.36911127 -.00000499 +00000-0 +10000-3 0 08380",
  #                          "2 11871 067.5731 001.8936 6344778 181.9632 173.2224 02.00993562062886"
  #                        ]),
  #   esa_goes_1: Tle.new([
  #                         "1 09931U 77029A   01309.17453186 -.00000329 +00000-0 +10000-3 0 05967",
  #                         "2 09931 026.4846 264.1300 6609654 082.2734 342.9061 01.96179522175451"
  #                       ]),
  #   cosmos_1217: Tle.new([
  #                          "1 12032U 80085A   01309.42683181  .00000182  00000-0  10000-3 0  3499",
  #                          "2 12032  65.2329  86.7607 7086222 172.0967 212.4632  2.00879501101699"
  #                        ]),
  #   molniya_3_19Rk: Tle.new([
  #                             "1 13446U 82083E   01283.10818257  .00098407  45745-7  54864-3 0  6240",
  #                             "2 13446  62.1717  83.8458 7498877 273.9677 320.2568  2.06357523137203"
  #                           ]),
  #   ariane_deb: Tle.new([
  #                         "1 23246U 91015G   01311.70347086  .00004957  00000-0  43218-2 0  8190",
  #                         "2 23246   7.1648 263.6949 5661268 241.8299  50.5793  4.44333001129208"
  #                       ])
  # }
  #
  # answers = {
  #   fake_1: {
  #     sgp4: {
  #       "0": {
  #         pos: Coordinates.new(2328.97048951,  -5995.22076416,   1719.97067261),
  #         vel: Coordinates.new(2.91207230,     -0.98341546,      -7.09081703)
  #       },
  #       "360": {
  #         pos: Coordinates.new(2456.10705566,  -6071.93853760,   1222.89727783),
  #         vel: Coordinates.new(2.67938992,     -0.44829041,      -7.22879231)
  #       },
  #       "720": {
  #         pos: Coordinates.new(2567.56195068,  -6112.50384522,    713.96397400),
  #         vel: Coordinates.new(2.44024599, 0.09810869, -7.31995916)
  #       },
  #       "1080": {
  #         pos: Coordinates.new(2663.09078980, -6115.48229980, 196.39640427),
  #         vel: Coordinates.new(2.19611958, 0.65241995, -7.36282432)
  #       },
  #       "1440": {
  #         pos: Coordinates.new(2742.55133057, -6079.67144775, -326.38095856),
  #         vel: Coordinates.new(1.94850229, 1.21106251, -7.35619372)
  #       }
  #     }
  #   },
  #   fake_2: {
  #     sdp4: {
  #       "0": {
  #         pos: Coordinates.new(7473.37066650, 428.95261765, 5828.74786377),
  #         vel: Coordinates.new(5.10715413, 6.44468284, -0.18613096)
  #       },
  #       "360": {
  #         pos: Coordinates.new(-3305.22537232, 32_410.86328125, -24_697.1767581),
  #         vel: Coordinates.new(-1.30113538, -1.15131518, -0.28333528)
  #       },
  #       "720": {
  #         pos: Coordinates.new(14_271.28759766, 24_110.46411133, -4725.76837158),
  #         vel: Coordinates.new(-0.32050445, 2.67984074, -2.08405289)
  #       },
  #       "1080": {
  #         pos: Coordinates.new(-9990.05883789, 22_717.35522461, -23_616.89062501),
  #         vel: Coordinates.new(-1.01667246, -2.29026759, 0.72892364)
  #       },
  #       "1440": {
  #         pos: Coordinates.new(9787.86975097, 33_753.34667969, -15_030.81176758),
  #         vel: Coordinates.new(-1.09425066, 0.92358845, -1.52230928)
  #       }
  #     }
  #   }
  # }
  #
  # epsilons = {
  #   sgp: 1e-4,
  #   sgp4: 1e-4,
  #   sgp8: 1e-4,
  #   sdp4: 1e-4,
  #   sdp8: 1e-4
  # }
  #
  # # NOTE: test_sat.cpp doesn't cover everything.
  # answers.each_pair do |satellite, params|
  #   params.each_pair do |ephemeris, answers|
  #     answers.each_pair do |since, answer|
  #       define_method("test_#{satellite}_#{ephemeris}_#{since}") do
  #         tle = satellites[satellite.to_sym]
  #         # Works because my names are ASCII
  #         propagator = Sgp4::Sgp4.new(tle)
  #         propagator.calculate(since.to_s.to_f)
  #         assert_in_epsilon answer[:pos].x, propagator.pos.x, epsilons[ephemeris]
  #         assert_in_epsilon answer[:pos].y, propagator.pos.y, epsilons[ephemeris]
  #         assert_in_epsilon answer[:pos].z, propagator.pos.z, epsilons[ephemeris]
  #         assert_in_epsilon answer[:vel].x, propagator.vel.x / 60.0, epsilons[ephemeris]
  #         assert_in_epsilon answer[:vel].y, propagator.vel.y / 60.0, epsilons[ephemeris]
  #         assert_in_epsilon answer[:vel].z, propagator.vel.z / 60.0, epsilons[ephemeris]
  #       end
  #     end
  #   end
  # end
end
