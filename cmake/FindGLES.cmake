#
# Try to find GLES library and include path.
# Once done this will define
#
# GLES_FOUND
# GLES_INCLUDE_PATH
# GLES_LIBRARY
#

if(EXISTS "/opt/vc/include/bcm_host.h")

    find_path(GLES_INCLUDE_DIR NAMES GLES/gl.h PATHS "/opt/vc/include/")

    # Look for RPi 4
    file(READ "/proc/device-tree/model" PIINFO)
    string(FIND "${PIINFO}" "Raspberry Pi 4 Model B" result)

    if(${result} EQUAL -1)
        find_library(GLES_LIBRARY NAMES brcmGLESv2 PATHS "/opt/vc/lib/")
    else()
        # Use GLESv1_CM for RPi 4
        find_library(GLES_LIBRARY NAMES GLESv1_CM PATHS "/usr/lib/")
    endif ()
else()
    find_path(GLES_INCLUDE_DIR GLES/gl.h)
    find_library(GLES_LIBRARY NAMES GLESv1_CM)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLES DEFAULT_MSG GLES_LIBRARY GLES_INCLUDE_DIR)
