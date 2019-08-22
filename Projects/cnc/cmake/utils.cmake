# Get all subdirectories under ${current_dir} and store them
# in ${result} variable
macro(subdirlist result current_dir)
    file(GLOB children ${current_dir}/*)
    set(dirlist "")

    foreach(child ${children})
        if (IS_DIRECTORY ${child})
            list(APPEND dirlist ${child})
        endif()
    endforeach()

    set(${result} ${dirlist})
endmacro()

# Prepend ${CMAKE_CURRENT_SOURCE_DIR} to a ${directory} name
# and save it in PARENT_SCOPE ${variable}
macro(prepend_cur_dir variable directory)
    set(${variable} ${CMAKE_CURRENT_SOURCE_DIR}/${directory})
endmacro()

# Add custom command to print firmware size in Berkley format
function(firmware_size target suffix)
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_SIZE} -B
        "${CMAKE_CURRENT_BINARY_DIR}/${target}${suffix}"
        COMMENT "Invoking: ARM GNU Print Size on ${target}${suffix}"
    )
endfunction()

# Add a command to generate firmare in a provided format
function(generate_object target suffix_in suffix_out type)
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O${type}
        "${CMAKE_CURRENT_BINARY_DIR}/${target}${suffix_in}" "${CMAKE_CURRENT_BINARY_DIR}/${target}${suffix_out}"
        COMMENT "Invoking: ARM GNU Objcopy on ${target}${suffix_in} to convert to ${suffix_out}"
    )
endfunction()

function(check_if_dir_exists directory)
    IF(NOT EXISTS ${directory})
        MESSAGE(SEND_ERROR  "Directory not found. Expected location: ${directory}")
    ENDIF()
endfunction()