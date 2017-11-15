#include <sgp4sdp4.h>

static VALUE rb_parse_elements(VALUE s);

VALUE mSgp4sdp4;

void Init_sgp4sdp4() {
  mSgp4sdp4 = rb_define_module("Sgp4sdp4");
  Init_sgp4sdp4_tle();

  // This may come out someday:
  rb_define_singleton_method(mSgp4sdp4, "parse_elements", rb_parse_elements, 1);
}

static VALUE rb_parse_elements(VALUE s) {
  return rb_str_new2("hello, world.");
}

// This is what you need:
// https://silverhammermba.github.io/emberb/c/
// https://github.com/ruby/ruby/blob/trunk/doc/extension.rdoc
// https://github.com/andremedeiros/ruby-c-cheat-sheet
