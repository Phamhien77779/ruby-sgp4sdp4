#include <sgp4.h>

static VALUE calculate(VALUE self, VALUE since) {
  elsetrec *satrec;
  double pos[3];
  double vel[3];
  VALUE rPos;
  VALUE rVel;

  VALUE tle = rb_iv_get(self, "@tle");
  VALUE gravitational_constant = rb_iv_get(tle, "@gravitational_constant");
  Data_Get_Struct(tle, elsetrec, satrec);
  // puts("ABOUT TO CALCULATE.");
  // printf("ABOUT TO CALCULATE. %f\n", NUM2DBL(since));
  sgp4_c(NUM2INT(gravitational_constant), satrec, NUM2DBL(since), pos, vel);
  rPos = rb_obj_alloc(cSgp4_coordinates);
  rb_funcall(rPos, rb_intern("initialize"), 3, DBL2NUM(pos[0]), DBL2NUM(pos[1]), DBL2NUM(pos[2]));
  rb_iv_set(self, "@pos", rPos);
  rVel = rb_obj_alloc(cSgp4_coordinates);
  rb_funcall(rVel, rb_intern("initialize"), 3, DBL2NUM(vel[0]), DBL2NUM(vel[1]), DBL2NUM(vel[2]));
  rb_iv_set(self, "@vel", rVel);
  // puts("DONE CALCULATING.");
  return self;
}

void Init_sgp4_sgp4() {
  VALUE cSgp4Sgp4 = rb_define_class_under(mSgp4, "Sgp4", rb_cObject);
  rb_define_method(cSgp4Sgp4, "calculate", calculate, 1);
  // rb_define_module_function(cSgp4Sgp4, "initialize", initialize, 1);
  // rb_define_alloc_func(cSgp4Sgp4, allocate);
  // puts("Leaving Init of Sgp4.\n");
}
