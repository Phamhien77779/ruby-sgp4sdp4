#include <sgp4.h>

VALUE mSgp4;
// VALUE cSgp4sdp4_ephemeris;
VALUE cSgp4_coordinates;

void Init_sgp4() {
  mSgp4 = rb_define_module("Sgp4");
  // cSgp4sdp4_ephemeris = rb_define_class_under(mSgp4, "Ephemeris", rb_cObject);
  cSgp4_coordinates = rb_define_class_under(mSgp4, "Coordinates", rb_cObject);
  Init_sgp4_tle();
  Init_sgp4_sgp4();
  // Init_sgp4sdp4_ephemeris();
  // Init_sgp4sdp4_sgp4();
}

// This is what you need:
// https://silverhammermba.github.io/emberb/c/
// https://github.com/ruby/ruby/blob/trunk/doc/extension.rdoc
// https://github.com/andremedeiros/ruby-c-cheat-sheet
