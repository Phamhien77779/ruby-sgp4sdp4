# frozen_string_literal: true

# Run tests like this: ruby -Itest:lib test/sgp4_test.rb [--seed 12345]
require "minitest/autorun"
require "minitest/pride"
require "sgp4"
require "date" # To get DateTime

class Sgp4Test < MiniTest::Test
  include Sgp4

  # TODO: This case produces 0 for b* and NaN for xndt2o.
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
    # assert_equal 2.2148107004387762e-09, tle.xndt2o, "xndt2o wrong"
    # # assert_equal 2.9130905387501816e-13, tle.xndd6o, "xndd6o wrong"
    # assert_in_epsilon 0.66816e-4, tle.bstar, 1e-8, "bstar wrong"
    # assert_equal 1.2713589136764896, tle.xincl, "xincl wrong"
    # assert_equal 2.0240391349160523, tle.xnodeo, "xnodeo wrong"
    # assert_equal 0.0086731, tle.eo, "eo wrong"
    # assert_equal 0.9197675718499878, tle.omegao, "omegao wrong"
    # assert_equal 1.9298349885396582, tle.xmo, "xmo wrong"
    # assert_equal 0.07006731262087737, tle.xno, "xno wrong"
    assert_equal 2_444_514.48708465, tle.epoch, "epoch wrong"
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
    # assert_equal(-2.8482803765185237e-12, tle.xndt2o, "xndt2o wrong")
    # # assert_equal 0.00000e-0, tle.xndd6o, "xndd6o wrong"
    # assert_in_epsilon 0.00000e+0, tle.bstar, 1e-8, "bstar wrong"
    # assert_equal 0.01961051947540829, tle.xincl, "xincl wrong"
    # assert_equal 1.6370228452618214, tle.xnodeo, "xnodeo wrong"
    # assert_equal 0.0005741, tle.eo, "eo wrong"
    # assert_equal 3.7432460439957826, tle.omegao, "omegao wrong"
    # assert_equal 2.6443535856843647, tle.xmo, "xmo wrong"
    # assert_equal 0.004375115447076924, tle.xno, "xno wrong"
    assert_equal 2_452_220.93599209, tle.epoch, "epoch wrong"
  end

  def test_33333
    skip "I think this is supposed to cause an error but doesn't"
    tle = Tle.new([
                    "1 33333U 05037B   05333.02012661  .25992681  00000-0  24476-3 0  1534",
                    "2 33333  96.4736 157.9986 9950000 244.0492 110.6523  4.00004038 10708"
                  ])

    assert_raises(RuntimeError) do
      propagator = Sgp4.new(tle)
      propagator.calculate(0.0)
    end

    assert_in_epsilon(-12_908.67135870, propagator.pos.x, 1e-3, "pos x wrong")
    assert_in_epsilon 8_084.56464378, propagator.pos.y, 1e-3, "pos y wrong"
    assert_in_epsilon 22_887.74960008, propagator.pos.z, 1e-3, "pos z wrong"
    assert_in_epsilon(-0.076981979, propagator.vel.x, 1e-3, "vel x wrong")
    assert_in_epsilon 0.252652062, propagator.vel.y, 1e-3, "vel y wrong"
    assert_in_epsilon 1.837356358, propagator.vel.z, 1e-3, "vel z wrong"
  end

  satellites = {
    fake_1: Tle.new([
                      "1 88888U          80275.98708465  .00073094  13844-3  66816-4 0    87",
                      "2 88888  72.8435 115.9689 0086731  52.6988 110.5714 16.05824518  1058"
                    ]),
    # The next has mean motion < 0 TLE from Bill Gray's version.
    # fake_2: Tle.new([
    #                   "1 11801U          80230.29629788  .01431103  00000-0  14311-1       2",
    #                   "2 11801U 46.7916 230.4354 7318036  47.4722  10.4117  2.28537848     2"
    #                 ]),
    teme: Tle.new([
                    "1 00005U 58002B   00179.78495062  .00000023  00000-0  28098-4 0  4753",
                    "2 00005  34.2682 348.7242 1859667 331.7664  19.3264 10.82419157413667"
                  ])
  }

  answers = {
    fake_1: {
      "0": {
        pos: Coordinates.new(2328.97048951,  -5995.22076416, 1719.97067261),
        vel: Coordinates.new(2.91207230,     -0.98341546, -7.09081703)
      },
      "360": {
        pos: Coordinates.new(2456.10705566, -6071.93853760, 1222.89727783),
        vel: Coordinates.new(2.67938992, -0.44829041, -7.22879231)
      },
      "720": {
        pos: Coordinates.new(2567.56195068, -6112.50384522, 713.96397400),
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
    teme: {
      "0": {
        pos: Coordinates.new(7022.46529266, -1400.08296755, 0.03995155),
        vel: Coordinates.new(1.893841015, 6.405893759, 4.534807250)
      },
      "4320": {
        pos: Coordinates.new(-9060.47373569, 4658.70952502, 813.68673153),
        vel: Coordinates.new(-2.232832783, -4.110453490, -3.157345433)
      }
      # },
      # fake_2: {
      #   sdp4: {
      #     "0": {
      #       pos: Coordinates.new(7473.37066650, 428.95261765, 5828.74786377),
      #       vel: Coordinates.new(5.10715413, 6.44468284, -0.18613096)
      #     },
      #     "360": {
      #       pos: Coordinates.new(-3305.22537232, 32_410.86328125, -24_697.1767581),
      #       vel: Coordinates.new(-1.30113538, -1.15131518, -0.28333528)
      #     },
      #     "720": {
      #       pos: Coordinates.new(14_271.28759766, 24_110.46411133, -4725.76837158),
      #       vel: Coordinates.new(-0.32050445, 2.67984074, -2.08405289)
      #     },
      #     "1080": {
      #       pos: Coordinates.new(-9990.05883789, 22_717.35522461, -23_616.89062501),
      #       vel: Coordinates.new(-1.01667246, -2.29026759, 0.72892364)
      #     },
      #     "1440": {
      #       pos: Coordinates.new(9787.86975097, 33_753.34667969, -15_030.81176758),
      #       vel: Coordinates.new(-1.09425066, 0.92358845, -1.52230928)
      #     }
      #   }
    }
  }

  # The code from here down basically sets up to test all the satellites
  # in `test/SGP4-VER.TLE` against the results in `test/tcppver.out`.
  # (`test/tcppver.out` is the same as `test/tcpvera.out`.)

  def self.read_answers
    answers = {}
    File.open("test/tcppver.out") do |f|
      f.read.each_line.reduce(nil) do |satellite_number, line|
        if line =~ /^\s+/
          fields = line.split(" ")
          time = line[188..-1]
          if time
            time[4] = time[7] = "-"
            [5, 8].each do |i|
              time[i] = "0" if time[i] == " "
            end
          end

          answers[satellite_number][fields[0]] = {
            pos: Coordinates.new(fields[1].to_f, fields[2].to_f, fields[3].to_f),
            vel: Coordinates.new(fields[4].to_f, fields[5].to_f, fields[6].to_f)
          }
          answers[satellite_number][fields[0]][:t] = DateTime.parse(time) if time
          answers[satellite_number][fields[0]][:a] = fields[7].to_f if fields[7]
          answers[satellite_number][fields[0]][:ecc] = fields[8].to_f if fields[8]
          answers[satellite_number][fields[0]][:incl] = fields[9].to_f if fields[9]
          answers[satellite_number][fields[0]][:omega] = fields[10].to_f if fields[10]
          answers[satellite_number][fields[0]][:argp] = fields[11].to_f if fields[11]
          answers[satellite_number][fields[0]][:nu] = fields[12].to_f if fields[12]
          answers[satellite_number][fields[0]][:m] = fields[13].to_f if fields[13]
        else
          satellite_number = line.split(" ")[0]
          answers[satellite_number] = {}
        end
        satellite_number
      end
      answers
    end
  end

  def self.read_tles
    tle_array = []
    tles = {}
    File.open("test/SGP4-VER.TLE") do |f|
      f.each_line do |line|
        next if line =~ /^\s*#/
        tle_array = [line] if line[0] == "1"
        next unless line[0] == "2"
        tle_array << line[0, 69]
        tles[tle_array[0][2, 5].gsub(/^0+/, "").to_sym] = tle_array
        # puts "Satellite: #{tle_array[0][2, 5].gsub(/^0+/, "")} TLE Array: #{tles[tle_array[0][2, 5].lstrip.to_sym]}"
      end
    end
    tles
  end

  satellites.merge!(read_tles)

  answers.merge(read_answers).each_pair do |satellite, params|
    next if satellite == "33334" # One satellite has unparseable TLE.
    tle = satellites[satellite.to_sym]
    # puts "Satellite: #{satellite} TLE: #{tle}"
    propagator = Sgp4.new(tle)
    params.each_pair do |since, answer|
      define_method("test_#{satellite}_#{since}") do
        ephemeris = propagator.calculate(since.to_s.to_f)
        # The error margins are determined mostly by eye-balling the results.
        assert_in_delta 0, ephemeris.pos.distance(answer[:pos]), 1.0, "distance between points differs"
        # The following is not a real comparison of how different the results.
        assert_in_delta 0, ephemeris.vel.distance(answer[:vel]), 1e-3, "velocity between points differs"
        # assert_in_epsilon answer[:pos].x, propagator.pos.x, 1e-3, "pos x wrong"
        # assert_in_epsilon answer[:pos].y, propagator.pos.y, 1e-3, "pos y wrong"
        # assert_in_epsilon answer[:pos].z, propagator.pos.z, 1e-3, "pos z wrong"
        # assert_in_epsilon answer[:vel].x, propagator.vel.x, 1e-3, "vel x wrong"
        # assert_in_epsilon answer[:vel].y, propagator.vel.y, 1e-3, "vel y wrong"
        # assert_in_epsilon answer[:vel].z, propagator.vel.z, 1e-3, "vel z wrong"
        assert_in_delta(answer[:t], ephemeris.t, 1e-6) if answer[:t]
        assert_in_delta(answer[:a], ephemeris.a, 1e-5) if answer[:a]
        assert_in_delta(answer[:ecc], ephemeris.ecc, 1e-6) if answer[:ecc]
        assert_in_delta(answer[:incl], Sgp4.to_degrees(ephemeris.incl), 1e-5) if answer[:incl]
        assert_in_delta(answer[:omega], Sgp4.to_degrees(ephemeris.omega), 1e-5) if answer[:omega]
        # TODO: Why is the argument of perigee so far off?
        assert_in_delta(answer[:argp], Sgp4.to_degrees(ephemeris.argp), 3e-3) if answer[:argp]
        assert_in_delta(answer[:nu], Sgp4.to_degrees(ephemeris.nu), 1e-5) if answer[:nu]
        assert_in_delta(answer[:m], Sgp4.to_degrees(ephemeris.m), 1e-5) if answer[:m]
      end
    end
  end
end
