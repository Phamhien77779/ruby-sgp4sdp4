#include <sgp4sdp4.h>

static void params_free(double *params) {
  // puts("Freeing.");
  free(params);
  // puts("Done freeing.");
}

static VALUE allocate(VALUE self) {
  // puts("Allocating.");
  double *params = malloc(sizeof(double) * N_SAT_PARAMS);
  // puts("Returning.");
  return Data_Wrap_Struct(self, NULL, params_free, params);
}

void Init_sgp4sdp4_ephemeris() {
  rb_define_alloc_func(cSgp4sdp4_ephemeris, allocate);
}
