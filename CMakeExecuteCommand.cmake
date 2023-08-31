
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
        
        macro(CMakeExecuteGitstringMessage msg)
            string(APPEND ${msg} "[EXIT CODE] : ${${prfx}_RESULT_VARIABLE}\n")
            if(NOT ${${prfx}_OUTPUT_VARIABLE} STREQUAL "")
                string(APPEND ${msg} "[OUTPUT_VARIABLE] : \n")
                string(APPEND ${msg} ${${prfx}_OUTPUT_VARIABLE})
            endif()
            if(NOT ${${prfx}_ERROR_VARIABLE} STREQUAL "")
                string(APPEND ${msg} "[ERROR_VARIABLE] : \n")
                string(APPEND ${msg} ${${prfx}_ERROR_VARIABLE})
            endif()
        endmacro()
            
        
        if( (${${prfx}_ASSERT} AND (NOT ${${prfx}_RESULT_VARIABLE} EQUAL 0)))
            CMakeExecuteGitstringMessage(msg)
            message(FATAL_ERROR ${msg})
        endif()
        
        if(${${prfx}_VERBOSE})
            CMakeExecuteGitstringMessage(msg)
            message(${msg})
        endif()
    endif()
    
    
    
endmacro()

