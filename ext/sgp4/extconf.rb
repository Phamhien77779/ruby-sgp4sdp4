# frozen_string_literal: true

require "mkmf"

$CFLAGS += " -x c"

create_makefile "sgp4/sgp4"
