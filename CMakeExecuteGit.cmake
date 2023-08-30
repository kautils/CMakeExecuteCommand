
macro(CMakeExecuteGit prfx)
    cmake_parse_arguments( ${prfx} "CLEAR;VERBOSE;VERBOSE_ERROR" "DIR" "COMMANDS" ${ARGN})
    set(${prfx}_unset)
    foreach(__var ${${prfx}_unset})
        unset(${__var})
    endforeach()
    unset(__var)
    if(${prfx}_CLEAR)

    else()
        set(${prfx}_unset ${prfx}_COMMANDS ${prfx}_DIR ${prfx}_RESULT_VARIABLE ${prfx}_OUTPUT_ERROR_VARIABLE ${prfx}_ERROR_VARIABLE)
        execute_process(
            COMMAND ${${prfx}_COMMANDS} 
            WORKING_DIRECTORY "${${prfx}_DIR}" 
            RESULT_VARIABLE ${prfx}_RESULT_VARIABLE
            OUTPUT_VARIABLE ${prfx}_OUTPUT_VARIABLE
            ERROR_VARIABLE ${prfx}_ERROR_VARIABLE
        )
        if(${prfx}_VERBOSE_ERROR AND NOT ${prfx}_ERROR_VARIABLE STREQUAL "")
            message(${${prfx}_ERROR_VARIABLE})
        endif()

        if(${prfx}_VERBOSE AND NOT ${prfx}_OUTPUT_VARIABLE STREQUAL "")
            message(${${prfx}_OUTPUT_VARIABLE})
        endif()
    endif()
endmacro()

