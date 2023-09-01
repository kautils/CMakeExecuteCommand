
macro(CMakeExecuteCommand prfx)
    
    if(NOT DEFINED ${prfx}_unset)
        foreach(__var ${${prfx}_unset})
            unset(${__var})
        endforeach()
        unset(__var)
        unset(${prfx}_unset)
    endif()
    
    cmake_parse_arguments( ${prfx} "VERBOSE;ASSERT;CLEAR" "DIR" "COMMAND" ${ARGN})
    if(NOT ${${prfx}_CLEAR})
        list(APPEND ${prfx}_unset ${prfx}_COMMAND ${prfx}_ASSERT ${prfx}_CLEAR ${prfx}_VERBOSE ${prfx}_DIR ${prfx}_RESULT_VARIABLE ${prfx}_OUTPUT_ERROR_VARIABLE ${prfx}_ERROR_VARIABLE)
        execute_process(
            COMMAND ${${prfx}_COMMAND} 
            WORKING_DIRECTORY "${${prfx}_DIR}" 
            RESULT_VARIABLE ${prfx}_RESULT_VARIABLE
            OUTPUT_VARIABLE ${prfx}_OUTPUT_VARIABLE
            ERROR_VARIABLE ${prfx}_ERROR_VARIABLE
        )
        
        macro(CMakeExecuteGitstringMessage __msg)
            string(APPEND ${__msg} "[EXIT CODE] : ${${prfx}_RESULT_VARIABLE}\n")
            
            string(APPEND ${__msg} "[COMMAND] : ")
            foreach(__com ${${prfx}_COMMAND})
                string(APPEND ${__msg} "${__com} ")
            endforeach()
            if(NOT ${${prfx}_OUTPUT_VARIABLE} STREQUAL "")
                string(APPEND ${__msg} "[OUTPUT_VARIABLE] : \n")
                string(APPEND ${__msg} ${${prfx}_OUTPUT_VARIABLE})
            endif()
            if(NOT ${${prfx}_ERROR_VARIABLE} STREQUAL "")
                string(APPEND ${__msg} "[ERROR_VARIABLE] : \n")
                string(APPEND ${__msg} ${${prfx}_ERROR_VARIABLE})
            endif()
        endmacro()
            
        
        if( (${${prfx}_ASSERT} AND (NOT ${${prfx}_RESULT_VARIABLE} EQUAL 0)))
            CMakeExecuteGitstringMessage(__msg)
            message(FATAL_ERROR ${__msg})
        endif()
        
        if(${${prfx}_VERBOSE})
            CMakeExecuteGitstringMessage(__msg)
            message(${__msg})
        endif()
    endif()
    
    unset(__msg)
    
endmacro()

