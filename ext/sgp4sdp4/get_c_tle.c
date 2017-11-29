#include <sgp4sdp4.h>

void get_c_tle(VALUE self, tle_t *cTle) {
  VALUE tmp_s;
  VALUE rTle = rb_iv_get(self, "@tle");

  cTle-> epoch = RFLOAT_VALUE(rb_iv_get(rTle, "@epoch"));
  cTle-> xndt2o = RFLOAT_VALUE(rb_iv_get(rTle, "@xndt2o"));
  cTle-> xndd6o = RFLOAT_VALUE(rb_iv_get(rTle, "@xndd6o"));
  cTle-> bstar = RFLOAT_VALUE(rb_iv_get(rTle, "@bstar"));
  cTle-> xincl = RFLOAT_VALUE(rb_iv_get(rTle, "@xincl"));
  cTle-> xnodeo = RFLOAT_VALUE(rb_iv_get(rTle, "@xnodeo"));
  cTle-> eo = RFLOAT_VALUE(rb_iv_get(rTle, "@eo"));
  cTle-> omegao = RFLOAT_VALUE(rb_iv_get(rTle, "@omegao"));
  cTle-> xmo = RFLOAT_VALUE(rb_iv_get(rTle, "@xmo"));
  cTle-> xno = RFLOAT_VALUE(rb_iv_get(rTle, "@xno"));
  cTle-> norad_number = NUM2INT(rb_iv_get(rTle, "@norad_number"));
  cTle-> bulletin_number = NUM2INT(rb_iv_get(rTle, "@bulletin_number"));
  cTle-> revolution_number = NUM2INT(rb_iv_get(rTle, "@revolution_number"));
  tmp_s = rb_iv_get(rTle, "@classification");
  cTle-> classification = *StringValueCStr(tmp_s);
  tmp_s = rb_iv_get(rTle, "@ephemeris_type");
  cTle-> ephemeris_type = *StringValueCStr(tmp_s);
  tmp_s = rb_iv_get(rTle, "@intl_desig");
  strncpy(cTle-> intl_desig, StringValueCStr(tmp_s), sizeof(cTle-> intl_desig) - 1);
  // printf("%s(%d): intl_desig: %.*s\n", __FILE__, __LINE__, (int)(sizeof cTle-> intl_desig - 1), cTle-> intl_desig);
}
