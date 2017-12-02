#include <sgp4.h>

static VALUE calculate(VALUE self, VALUE since) {
  elsetrec *satrec;
  double pos[3];
  double vel[3];
  double c_since = NUM2DBL(since);
  VALUE rPos;
  VALUE rVel;
  VALUE cEphemeris;

  VALUE tle = rb_iv_get(self, "@tle");
  VALUE gravitational_constant = rb_iv_get(tle, "@gravitational_constant");
  Data_Get_Struct(tle, elsetrec, satrec);
  // puts("ABOUT TO CALCULATE.");
  // printf("ABOUT TO CALCULATE. %f\n", NUM2DBL(since));
  sgp4_c(NUM2INT(gravitational_constant), satrec, c_since, pos, vel);

  // printf("Calculated error code: %d\n", satrec-> error);

  if (satrec-> error != 0) {
    rb_raise(rb_eRuntimeError, "Unable to calculate location: %s", error_message(satrec-> error));
  }

  rPos = rb_obj_alloc(cSgp4_coordinates);
  rb_funcall(rPos, rb_intern("initialize"), 3, DBL2NUM(pos[0]), DBL2NUM(pos[1]), DBL2NUM(pos[2]));
  rb_iv_set(self, "@pos", rPos);
  rVel = rb_obj_alloc(cSgp4_coordinates);
  rb_funcall(rVel, rb_intern("initialize"), 3, DBL2NUM(vel[0]), DBL2NUM(vel[1]), DBL2NUM(vel[2]));
  rb_iv_set(self, "@vel", rVel);
  // puts("DONE CALCULATING.");

  int  year, mon, day, hr, min;
  double sec;
  // TODO: Add this to epoch in the Tle.
  double jd = satrec-> jdsatepoch + c_since / 1440.0;
  invjday_c(jd, &year, &mon, &day, &hr, &min, &sec);
  VALUE cDatetime = rb_const_get(rb_cObject, rb_intern("DateTime"));
  VALUE datetime = rb_funcall(cDatetime,
    rb_intern("new"),
    6,
    INT2NUM(year),
    INT2NUM(mon),
    INT2NUM(day),
    INT2NUM(hr),
    INT2NUM(min),
    DBL2NUM(sec));

  cEphemeris = rb_const_get(mSgp4, rb_intern("Ephemeris"));
  VALUE ephemeris = rb_funcall(cEphemeris, rb_intern("new"), 3, datetime, rPos, rVel);

  return ephemeris;
}

void Init_sgp4_sgp4() {
  VALUE cSgp4Sgp4 = rb_define_class_under(mSgp4, "Sgp4", rb_cObject);
  rb_define_method(cSgp4Sgp4, "calculate", calculate, 1);
  // Because I'm going to be using DateTime.
  rb_require("date");
  // rb_define_module_function(cSgp4Sgp4, "initialize", initialize, 1);
  // rb_define_alloc_func(cSgp4Sgp4, allocate);
  // puts("Leaving Init of Sgp4.\n");
}
