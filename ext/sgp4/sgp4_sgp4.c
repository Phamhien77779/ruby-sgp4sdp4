#include <sgp4.h>

void Init_sgp4_sgp4() {
  VALUE cSgp4Sgp4 = rb_define_class_under(mSgp4, "Sgp4", rb_cObject);
  // rb_define_module_function(cSgp4Sgp4, "initialize", initialize, 1);
  // rb_define_alloc_func(cSgp4Sgp4, allocate);
  // puts("Leaving Init of Sgp4.\n");
}
