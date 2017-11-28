#ifndef SGP4
#define SGP4

#include <ruby.h>
#include <sgp4wrapper.h>

extern VALUE mSgp4;
extern VALUE cSgp4_coordinates;

extern void Init_sgp4_tle();
extern void Init_sgp4_sgp4();
extern char* error_message(size_t);

#endif
