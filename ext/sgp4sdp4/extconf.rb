# frozen_string_literal: true

require "mkmf"

# abort "missing rb_parse_elements()" unless have_func "rb_parse_elements"
# From: http://blog.zachallett.com/howto-ruby-c-extension-with-a-static-library/

LIBDIR     = RbConfig::CONFIG["libdir"]
INCLUDEDIR = RbConfig::CONFIG["includedir"]

HEADER_DIRS = [INCLUDEDIR, File.expand_path(File.join(File.dirname(__FILE__), "sat_code"))].freeze

# setup constant that is equal to that of the file path that holds that static libraries that will need to be compiled against
LIB_DIRS = [LIBDIR, File.expand_path(File.join(File.dirname(__FILE__), "sat_code"))].freeze

# array of all libraries that the C extension should be compiled against
libs = ["-lsatell"]

dir_config("sgp4sdp4", HEADER_DIRS, LIB_DIRS)

# iterate though the libs array, and append them to the $LOCAL_LIBS array used for the makefile creation
libs.each do |lib|
  $LOCAL_LIBS << "#{lib} "
end

create_makefile "sgp4sdp4/sgp4sdp4"
