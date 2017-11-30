#include <sgp4.h>

static void tle_free(elsetrec *tle) {
  free(tle);
}

static VALUE allocate(VALUE self) {
  elsetrec *tle = malloc(sizeof(elsetrec));
  return Data_Wrap_Struct(self, NULL, tle_free, tle);
}

static VALUE initialize(VALUE self, VALUE rb_array) {
  char *l1;

  // Needed for software the way it was packaged.
  // The test data distributed with the STR #3 revised report assumes
  // wgs72. wgs84 will cause significantly different answers.
  gravconsttype whichconst = wgs72; // Hard code for now.
  elsetrec *satrec;
  // Only needed for interface to function:
  double startmfe, stopmfe, deltamin;

  Check_Type(rb_array, T_ARRAY);

  // NOTE: This egregious hack because twoline2rv modifies the input strings.
  char line1[69];
  VALUE tmp = rb_ary_entry(rb_array, 0);
  memcpy(line1, StringValueCStr(tmp), sizeof line1);
  char line2[69];
  tmp = rb_ary_entry(rb_array, 1);
  memcpy(line2, StringValueCStr(tmp), sizeof line2);

  Data_Get_Struct(self, elsetrec, satrec);
  twoline2rv_c(line1,
    line2,
    'c', // typerun, Hard code to get useless start and stop time.
    'm', // typeinput, Believed to be don't care with the other hard coding.
    'i', // opsmode, Hard code to "improved" instead of best guess of AFSPC.
    whichconst,
    &startmfe,
    &stopmfe,
    &deltamin,
    satrec);

  if (satrec-> error != 0) {
    rb_raise(rb_eRuntimeError, "Unparseable two-line elements: %s", error_message(satrec-> error));
  }

  rb_iv_set(self, "@gravitational_constant", INT2NUM(whichconst));

  // printf("tle.epoch: %lf\n", tle.epoch);

  // rb_iv_set(self, "@epoch", DBL2NUM(satrec-> epoch));
  // printf("@epoch: %lf\n", NUM2DBL(rb_iv_get(self, "@epoch")));
  // printf("satrec-> xndt2o: %f\n", satrec-> xndt2o);
  rb_iv_set(self, "@xndt2o", DBL2NUM(satrec-> nddot));
  // printf("@xndt2o: %f\n", NUM2DBL(rb_iv_get(self, "@xndt2o")));
  // rb_iv_set(self, "@xndd6o", DBL2NUM(satrec-> xndd6o));
  rb_iv_set(self, "@bstar", DBL2NUM(satrec-> bstar));
  rb_iv_set(self, "@xincl", DBL2NUM(satrec-> inclo));
  rb_iv_set(self, "@xnodeo", DBL2NUM(satrec-> nodeo));
  rb_iv_set(self, "@eo", DBL2NUM(satrec-> ecco));
  rb_iv_set(self, "@omegao", DBL2NUM(satrec-> argpo));
  rb_iv_set(self, "@xmo", DBL2NUM(satrec-> mo));
  rb_iv_set(self, "@xno", DBL2NUM(satrec-> no));
  rb_iv_set(self, "@norad_number", INT2NUM(satrec-> satnum));
  // rb_iv_set(self, "@bulletin_number", INT2NUM(satrec-> bulletin_number));
  char tbuff[6];
  memcpy( tbuff, line2 + 63, 5);
  tbuff[5] = '\0';
  rb_iv_set(self, "@revolution_number", INT2NUM(atoi(tbuff)));
  // rb_iv_set(self, "@classification", rb_str_new(&(satrec-> classification), 1));
  // rb_iv_set(self, "@ephemeris_type", rb_str_new(&(satrec-> ephemeris_type), 1));
  // rb_iv_set(self, "@intl_desig", rb_str_new2(satrec-> intl_desig));

  return self;
}

void Init_sgp4_tle() {
  VALUE cSgp4Tle = rb_define_class_under(mSgp4, "Tle", rb_cObject);
  rb_define_module_function(cSgp4Tle, "initialize", initialize, 1);
  rb_define_alloc_func(cSgp4Tle, allocate);
  // puts("Leaving Init of Tle.\n");
}
