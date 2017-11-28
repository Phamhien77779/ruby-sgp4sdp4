#include <sgp4.h>

char* error_message(size_t error_code) {
  static char* error_messages[] = {
    "mean elements, ecc >= 1.0 or ecc < -0.001 or a < 0.95 er",
    "mean motion less than 0.0",
    "pert elements, ecc < 0.0  or  ecc > 1.0",
    "semi-latus rectum < 0.0",
    "epoch elements are sub-orbital",
    "satellite has decayed",
    "unknown error code"
  };
  size_t error_index = error_code - 1;

  if (sizeof error_messages <= error_index) {
    error_index = sizeof(error_messages) - 1;
  }

  return error_messages[error_index];
}
