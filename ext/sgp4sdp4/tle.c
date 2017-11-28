#include <sgp4sdp4.h>
#include <stdio.h>

// static VALUE allocate(VALUE klass) {
//   return Data_Wrap_Struct(klass, NULL, deallocate, string);
// }

static VALUE initialize(VALUE self, VALUE rb_array) {
  tle_t tle;
  char *l1;

  Check_Type(rb_array, T_ARRAY);

  VALUE line1 = rb_ary_entry(rb_array, 0);
  VALUE line2 = rb_ary_entry(rb_array, 1);
  // puts(l1 = StringValueCStr(line1));
  // printf("%s length: %ld\n", l1, strlen(l1));
  if (parse_elements(StringValueCStr(line1), StringValueCStr(line2), &tle) < 0) {
    rb_raise(rb_eRuntimeError, "Unparseable two-line elements");
  }

  // printf("tle.epoch: %lf\n", tle.epoch);

  rb_iv_set(self, "@epoch", DBL2NUM(tle.epoch));
  // printf("@epoch: %lf\n", NUM2DBL(rb_iv_get(self, "@epoch")));
  // printf("tle.xndt2o: %f\n", tle.xndt2o);
  rb_iv_set(self, "@xndt2o", DBL2NUM(tle.xndt2o));
  // printf("@xndt2o: %f\n", NUM2DBL(rb_iv_get(self, "@xndt2o")));
  rb_iv_set(self, "@xndd6o", DBL2NUM(tle.xndd6o));
  rb_iv_set(self, "@bstar", DBL2NUM(tle.bstar));
  rb_iv_set(self, "@xincl", DBL2NUM(tle.xincl));
  rb_iv_set(self, "@xnodeo", DBL2NUM(tle.xnodeo));
  rb_iv_set(self, "@eo", DBL2NUM(tle.eo));
  rb_iv_set(self, "@omegao", DBL2NUM(tle.omegao));
  rb_iv_set(self, "@xmo", DBL2NUM(tle.xmo));
  rb_iv_set(self, "@xno", DBL2NUM(tle.xno));
  rb_iv_set(self, "@norad_number", INT2NUM(tle.norad_number));
  rb_iv_set(self, "@bulletin_number", INT2NUM(tle.bulletin_number));
  rb_iv_set(self, "@revolution_number", INT2NUM(tle.revolution_number));
  rb_iv_set(self, "@classification", rb_str_new(&(tle.classification), 1));
  rb_iv_set(self, "@ephemeris_type", rb_str_new(&(tle.ephemeris_type), 1));
  // The buffer for intl_desig has space for a NUL.
  rb_iv_set(self, "@intl_desig", rb_str_new(tle.intl_desig, sizeof tle.intl_desig - 1));

  return self;
}

void Init_sgp4sdp4_tle() {
  VALUE cSgp4sdp4Tle = rb_define_class_under(mSgp4sdp4, "Tle", rb_cObject);
  rb_define_module_function(cSgp4sdp4Tle, "initialize", initialize, 1);
  // rb_define_alloc_func(cSgp4sdp4Tle, allocate);
  // puts("Leaving Init of Tle.\n");
}
