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

# Functions treat args as variables Macros treat args as string replacements
# (same as in C)

# ARGC/ARGV/ARGN used to handle variadic functions ARGN contains arguments
# beyond named ones
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
