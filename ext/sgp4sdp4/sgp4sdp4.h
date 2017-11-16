#ifndef SGP4SDP4
#define SGP4SDP4

#include <ruby.h>
#include <norad.h>

extern VALUE mSgp4sdp4;
extern VALUE cSgp4sdp4_ephemeris;
extern VALUE cSgp4sdp4_coordinates;

extern void Init_sgp4sdp4_tle();
extern void Init_sgp4sdp4_ephemeris();
extern void Init_sgp4sdp4_sgp();
extern void Init_sgp4sdp4_sgp4();
extern void get_c_tle(VALUE self, tle_t *cTle);

#endif
