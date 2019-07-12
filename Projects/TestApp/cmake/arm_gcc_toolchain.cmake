
if(_TOOLCHAIN_LOADED)
    return()
endif()

set(_TOOLCHAIN_LOADED TRUE)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_FLAGS_INIT   "${MCU} ${COMMON_FLAGS} ${C_DEFS} -std=c11"
                    CACHE STRING "c compiler flags")
set(CMAKE_CXX_FLAGS_INIT "${MCU} ${COMMON_FLAGS} ${C_DEFS} -std=c++14 -fno-rtti -fno-exceptions"
                    CACHE STRING "cxx compiler flags")
set(CMAKE_ASM_FLAGS_INIT "${MCU} ${COMMON_FLAGS} -x assembler-with-cpp"
                    CACHE STRING "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${MCU} ${MCU_LINKER_FLAGS}"
                    CACHE STRING "executable linker flags")

set(triplet arm-none-eabi)

find_path(CMAKE_SYSROOT include/stdint.h
    PATH_SUFFIXES ${triplet}
    HINTS
    ${PROJECT_SOURCE_DIR}\\..\\..\\Sandbox\\gcc
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\ARM\\GNU Tools for ARM Embedded Processors;InstallFolder]"
    /opt
    /usr/local
    /usr
    DOC "Path containing the system headers and libraries for the target (e.g. <some_path>/${triplet})"
)

# Check the sysroot is valid.
get_filename_component(triplet_in_sysroot "${CMAKE_SYSROOT}/${triplet}" NAME)
if(NOT triplet STREQUAL triplet_in_sysroot)
    message(FATAL_ERROR "The CMAKE_SYSROOT should be a path of the form <some_path>/${triplet}.")
endif()

if(WIN32)
    set(exe_suffix ".exe")
else()
    set(exe_suffix "")
endif()

# Usually, a toolchain folder hierarchy is as follow:
# <path>/<triplet> (this is the CMAKE_SYSROOT)
# <path>/bin (this contains the cross-tools)
#
# Thus we will look for the cross-tools from the sysroot.
get_filename_component(hints "${CMAKE_SYSROOT}" DIRECTORY)
set(hints "${hints}/bin")

find_program(CMAKE_C_COMPILER   NAMES ${triplet}-gcc${exe_suffix}        HINTS "${hints}" DOC "C compiler path")
find_program(CMAKE_CXX_COMPILER NAMES ${triplet}-g++${exe_suffix}        HINTS "${hints}" DOC "C++ compiler path")
find_program(CMAKE_ASM_COMPILER NAMES ${triplet}-gcc${exe_suffix}        HINTS "${hints}" DOC "ASM compiler path")
find_program(CMAKE_AR           NAMES ${triplet}-gcc-ar${exe_suffix}     HINTS "${hints}" DOC "Archiver path")
find_program(CMAKE_LINKER       NAMES ${triplet}-ld${exe_suffix}         HINTS "${hints}" DOC "Linker path")
find_program(CMAKE_NM           NAMES ${triplet}-nm${exe_suffix}         HINTS "${hints}" DOC "Symbols lister path")
find_program(CMAKE_OBJCOPY      NAMES ${triplet}-objcopy${exe_suffix}    HINTS "${hints}" DOC "Object copier path")
find_program(CMAKE_OBJDUMP      NAMES ${triplet}-objdump${exe_suffix}    HINTS "${hints}" DOC "Object displayer path")
find_program(CMAKE_STRIP        NAMES ${triplet}-strip${exe_suffix}      HINTS "${hints}" DOC "Symbol discarder path")
find_program(CMAKE_SIZE         NAMES ${triplet}-size${exe_suffix}       HINTS "${hints}" DOC "Object size lister path")
find_program(CMAKE_CPPFILT      NAMES ${triplet}-c++filt${exe_suffix}    HINTS "${hints}" DOC "Symbols demangler path")
find_program(CMAKE_RANLIB       NAMES ${triplet}-gcc-ranlib${exe_suffix} HINTS "${hints}" DOC "Index generator path")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
