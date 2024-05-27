#[[
9.1 Basics
]]
function(name [arg1 [arg2 [...]]])

endfunction()
macro(name [arg1 [arg2 [...]]]) # similar to #define in C

endmacro()

# funcion naming is case-insensitive, however standard is lower_case()

#[[
9.2 Argument Handling
]]

# Functions treat args as variables Macros treat args as string replacements (same as in C)

# ARGC/ARGV/ARGN used to handle variadic functions ARGN contains arguments beyond named ones
function(add_mytest targetName)
    add_executable(${target} ${ARGN})
    target_link_libraries(${targetName} PRIVATE foobar)
    add_test(NAME ${targetName} COMMAND ${targetName})
endfunction()

add_mytest(smallTest small.cpp)
add_mytest(bigTest big.cpp algo.cpp net.cpp)

function(func)
    foreach(arg IN LISTS ARGN)
        message("Arg: ${arg}")
    endforeach()
endfunction()

#[[
9.3 Keyword Arguments
]]
# Used to parse complicated inputs to a function. Not allowed in Macros
cmake_parse_arguments(PARSE_ARGV startIndex prefix valuelessKeywords singleValueKeywords
                      multiValueKeywords)
function(func)
    # define supported keywords CAPS are the keywords (like optional input types)
    set(prefix ARG) # function name?
    set(noValues ENABLE_NET COOL_STUFF) # flags
    set(singleValues TARGET) # items
    set(multiValues SOURCES IMAGES) # lists

    # leftover args are stored in <prefix>_UNPARSED_ARGUMENTS arg expecting value(s), but without
    # them provided are listed in <prefix>_KEYWORDS_MISSING_VALUES

    # process arguments option 1
    cmake_parse_arguments(${prefix} "${noValues}" "${singleValues}" "${multiValues}" ${ARGN})
    # OR process arguments option 2 (better if unparsed args are lists)
    cmake_parse_arguments(PARSE_ARGV 0 ${prefix} "${noValues}" "${singleValues}" "${multiValues}")

    # log details for each supported keyword
    message("Option summary:")
    foreach(arg IN LISTS noValues)
        if(${prefix}_${arg})
            message("  ${arg} enabled")
        else()
            message("  ${arg} disabled")
        endif()
    endforeach()
    foreach(arg IN LISTS singleValues multiValues)
        # Single argument values will print as a string Multiple argument values will print as a
        # list
        message(" ${arg} = ${${prefix}_${arg}}")
    endforeach()
endfunction()
# Examples of calling with different combinations of keyword arguments
func(SOURCES foo.cpp bar.cpp TARGET MyApp ENABLE_NET)
func(
    COOL_STUFF
    TARGET
    dummy
    IMAGES
    here.png
    there.png
    gone.png)

# Pretty cool multi-level argument parsing example:
function(lib_with_test)
    # First level of arguments
    set(groups LIB TEST)
    cmake_parse_arguments(GRP "" "" "${groups}" ${ARGN})
    # Second level of arguments
    set(args SOURCES PRIVATE_LIBS PUBLIC_LIBS)
    cmake_parse_arguments(LIB "" "TARGET" "${args}" ${GRP_LIB})
    cmake_parse_arguments(TEST "" "TARGET" "${args}" ${GRP_TEST})
    add_library(${LIB_TARGET} ${LIB_SOURCES})
    target_link_libraries(
        ${LIB_TARGET}
        PUBLIC ${LIB_PUBLIC_LIBS}
        PRIVATE ${LIB_PRIVATE_LIBS})
    add_executable(${TEST_TARGET} ${TEST_SOURCES})
    target_link_libraries(
        ${TEST_TARGET}
        PUBLIC ${TEST_PUBLIC_LIBS}
        PRIVATE ${LIB_TARGET} ${TEST_PRIVATE_LIBS})
endfunction()

lib_with_test(
    LIB
    TARGET
    Algo
    SOURCES
    algo.cpp
    algo.h
    PUBLIC_LIBS
    SomeMathHelpers
    TEST
    TARGET
    AlgoTest
    SOURCES
    algoTest.cpp
    PRIVATE_LIBS
    gtest_main)

#[[
9.4 Returning Values
]]
# Functions introduce new var scope, macros are inline injections

#[[
9.6 Special variables for FUNCTIONS
    CMAKE_CURRENT_FUNCTION
        Holds the name of the function currently being executed.
    CMAKE_CURRENT_FUNCTION_LIST_FILE
        Contains the full path to the file that defined the function currently being executed.
    CMAKE_CURRENT_FUNCTION_LIST_DIR
        Holds the absolute directory containing the file that defined the function currently being
        executed.
    CMAKE_CURRENT_FUNCTION_LIST_LINE
        Holds the line number at which the currently executing function was defined within the file
        that defined it.
]]

# useful to refer to files that define internal implementation details of function
set(__writeSomeFile_DIR ${CMAKE_CURRENT_LIST_DIR})
function(writeSomeFile toWhere)
    configure_file(${__writeSomeFile_DIR}/template.cpp.in ${toWhere} @ONLY)
endfunction()

#[[
9.7 Other Ways to Invoke CMAKE
]]
cmake_language(CALL command [args...])
cmake_language(EVAL CODE code...) # Used to execute any valid cmake script

# Basically code injection
set(myProjTraceCall
    [=[
    message("Hello World!")
    set(__x 0)
    math(EXPR __x "${__x} + 1")
    message("x = ${__x}")
]=])

function(func)
    cmake_language(EVAL CODE "${myProjTraceCall}")
endfunction()

# Basically delayed/lazy code injection
cmake_language(
    DEFER
    [DIRECTORY
    dir]
    [ID
    id
    |
    ID_VAR
    outVar]
    CALL
    command
    [args...])
