cmake_minimum_required(VERSION 3.9)

include(utils)


add_compile_options($<$<CONFIG:Debug>:-Og>)
if(NOT CMAKE_BUILD_TYPE STREQUAL Debug)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()

function(embedded_executible target)
    add_executable(${target} ${ARGN})
    set_target_properties(${target} PROPERTIES RUNTIME_OUTPUT_NAME ${target}.elf)
    generate_object(${target} .elf .hex ihex)
    generate_object(${target} .elf .bin binary)
    firmware_size(${target} .hex)

    # Common base libraries
    target_link_libraries(${target} core)
endfunction()

