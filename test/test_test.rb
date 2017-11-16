# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/*_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4sdp4"

class TestTest < MiniTest::Test
  include Sgp4sdp4

  satellites = {
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

  answers = {
    fake_1: {
      sgp: {
        "0": {
          pos: Coordinates.new(2328.96594238, -5995.21600342, 1719.97894287),
          vel: Coordinates.new(2.91110113, -0.98164053, -7.09049922)
        },
        "360": {
          pos: Coordinates.new(2456.00610352, -6071.94232177, 1222.95977784),
          vel: Coordinates.new(2.67852119, -0.44705850, -7.22800565)
        },
        "720": {
          pos: Coordinates.new(2567.39477539, -6112.49725342, 713.97710419),
          vel: Coordinates.new(2.43952477, 0.09884824, -7.31899641)
        },
        "1080": {
          pos: Coordinates.new(2663.03179932, -6115.37414551, 195.73919105),
          vel: Coordinates.new(2.19531813, 0.65333930, -7.36169147)
        },
        "1440": {
          pos: Coordinates.new(2742.85470581, -6079.13580322, -328.86091614),
          vel: Coordinates.new(1.94707947, 1.21346101, -7.35499924)
        }
      },
      sgp4: {
        "0": {
          pos: Coordinates.new(2328.97048951,  -5995.22076416,   1719.97067261),
          vel: Coordinates.new(2.91207230,     -0.98341546,      -7.09081703)
        },
        "360": {
          pos: Coordinates.new(2456.10705566,  -6071.93853760,   1222.89727783),
          vel: Coordinates.new(2.67938992,     -0.44829041,      -7.22879231)
        },
        "720": {
          pos: Coordinates.new(2567.56195068,  -6112.50384522,    713.96397400),
          vel: Coordinates.new(2.44024599, 0.09810869, -7.31995916)
        },
        "1080": {
          pos: Coordinates.new(2663.09078980, -6115.48229980, 196.39640427),
          vel: Coordinates.new(2.19611958, 0.65241995, -7.36282432)
        },
        "1440": {
          pos: Coordinates.new(2742.55133057, -6079.67144775, -326.38095856),
          vel: Coordinates.new(1.94850229, 1.21106251, -7.35619372)
        }
      },
      sgp8: {
        "0": {
          pos: Coordinates.new(2328.87265015,  -5995.21289063,   1720.04884338),
          vel: Coordinates.new(2.91210661,     -0.98353850,      -7.09081554)
        },
        "360": {
          pos: Coordinates.new(2456.04577637,  -6071.90490722,   1222.84086609),
          vel: Coordinates.new(2.67936245,     -0.44820847,      -7.22888553)
        },
        "720": {
          pos: Coordinates.new(2567.68383789,  -6112.40881348,    713.29282379),
          vel: Coordinates.new(2.43992555, 0.09893919, -7.32018769)
        },
        "1080": {
          pos: Coordinates.new(2663.49508667, -6115.18182373, 194.62816810),
          vel: Coordinates.new(2.19525236, 0.65453661, -7.36308974)
        },
        "1440": {
          pos: Coordinates.new(2743.29238892, -6078.90783691, -329.73434067),
          vel: Coordinates.new(1.94680957, 1.21500109, -7.35625595)
        }
      }
    },
    fake_2: {
      sdp4: {
        "0": {
          pos: Coordinates.new(7473.37066650, 428.95261765, 5828.74786377),
          vel: Coordinates.new(5.10715413, 6.44468284, -0.18613096)
        },
        "360": {
          pos: Coordinates.new(-3305.22537232, 32_410.86328125, -24_697.1767581),
          vel: Coordinates.new(-1.30113538, -1.15131518, -0.28333528)
        },
        "720": {
          pos: Coordinates.new(14_271.28759766, 24_110.46411133, -4725.76837158),
          vel: Coordinates.new(-0.32050445, 2.67984074, -2.08405289)
        },
        "1080": {
          pos: Coordinates.new(-9990.05883789, 22_717.35522461, -23_616.89062501),
          vel: Coordinates.new(-1.01667246, -2.29026759, 0.72892364)
        },
        "1440": {
          pos: Coordinates.new(9787.86975097, 33_753.34667969, -15_030.81176758),
          vel: Coordinates.new(-1.09425066, 0.92358845, -1.52230928)
        }
      },
      sdp8: {
        "0": {
          pos: Coordinates.new(7469.47631836, 415.99390792, 5829.64318848),
          vel: Coordinates.new(5.11402285, 6.44403201, -0.18296110)
        },
        "360": {
          pos: Coordinates.new(-3337.38992310, 32_351.39086914, -24_658.63037109),
          vel: Coordinates.new(-1.30200730, -1.15603013, -0.28164955)
        },
        "720": {
          pos: Coordinates.new(14_226.54333496, 24_236.08740234, -4856.19744873),
          vel: Coordinates.new(-0.33951668, 2.65315416, -2.08114153)
        },
        "1080": {
          pos: Coordinates.new(-10_151.59838867, 22_223.69848633, -23_392.39770508),
          vel: Coordinates.new(-1.00112480, -2.33532837, 0.76987664)
        },
        "1440": {
          pos: Coordinates.new(9420.08203125, 33_847.21875000, -15_391.06469727),
          vel: Coordinates.new(-1.11986055, 0.85410149, -1.49506933)
        }
      }
    }
  }

  epsilons = {
    sgp: 1e-4,
    sgp4: 1e-4,
    sgp8: 1e-4,
    sdp4: 1e-4,
    sdp8: 1e-4
  }

  # NOTE: test_sat.cpp doesn't cover everything.
  answers.each_pair do |satellite, params|
    params.each_pair do |ephemeris, answers|
      answers.each_pair do |since, answer|
        define_method("test_#{satellite}_#{ephemeris}_#{since}") do
          tle = satellites[satellite.to_sym]
          # Works because my names are ASCII
          propagator = Module.const_get("Sgp4sdp4::" + ephemeris.to_s.capitalize).new(tle)
          propagator.calculate(since.to_s.to_f)
          assert_in_epsilon answer[:pos].x, propagator.pos.x, epsilons[ephemeris]
          assert_in_epsilon answer[:pos].y, propagator.pos.y, epsilons[ephemeris]
          assert_in_epsilon answer[:pos].z, propagator.pos.z, epsilons[ephemeris]
          assert_in_epsilon answer[:vel].x, propagator.vel.x / 60.0, epsilons[ephemeris]
          assert_in_epsilon answer[:vel].y, propagator.vel.y / 60.0, epsilons[ephemeris]
          assert_in_epsilon answer[:vel].z, propagator.vel.z / 60.0, epsilons[ephemeris]
        end
      end
    end
  end
end
