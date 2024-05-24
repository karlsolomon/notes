#[[
7.1 if(expr) (case-insensitive)
    True:
        {ON, YES, TRUE, Y, "ON", "YES", "TRUE", "Y"}
    False:
        {OFF, NO, FALSE, N, IGNORE, NOTFOUND, "", or ".*-NOTFOUND"}
    Number: converted to bool following normal C rules. Bad practice to use anything other than 0/1
    Anything Else: Treat as variable name and evaluated per "fall through case" if(<variable|string>)
]]

if(expr1)
    #
elseif(expr2)
    #
else()
    #
endif()

# envars DO NOT count as variables
if(ENV{variable}) # ALWAYS evaluates FALSE

if(<variable|string>)
#[[
fall-through case (unquoted)
    if value is anything other than the "false" values above, it evaluates to true
    undefined variable => evaluates to false (empty string)
fall-through case (quoted)
    if string is anything other than "true" values above, it evaluates to false
]]

#Operators
#NOT AND OR
if(NOT a)
if(a AND b)
if(a OR b)

#Comparison
Numeric,String,VersionNum,Path
LESS,STRLESS,VERSION_LESS,
GREATER,STRGREATER,VERSION_GREATER,
EQUAL,STREQUAL,VERSION_EQUAL,PATH_EQUAL
LESS_EQUAL,STRLESS_EQUAL,VERSION_LESS_EQUAL,
GREATER_EQUAL,STRGREATER_EQUAL,VERSION_GREATER_EQUAL,
#difference between PATH_EQUAL and STREQUAL:
if("/a//b/c" PATH_EQUAL "/a/b/c") # TRUE
endif()
if("/a//b/c" STREQUAL "/a/b/c") # FALSE
endif()

if(val MATCHES regex)

#File System Tests
if(EXISTS filepath) # implied also IS_READABLE
if(IS_READABLE filepath)
if(IS_WRITEABLE filepath)
if(IS_EXECUTABLE filepath)
if(IS_DIRECTORY filepath)
if(IS_SYMLINK filepath)
if(IS_ABSOLUTE path)
if(file1 IS_NEWER_THAN file2)

#Cmake Existence Tests
if(DEFINED name)
    if(DEFINED VAR) # can be regular or cache (same as if(DEFINED CACHE{a} OR DEFINED ENV{a}))
    if(DEFINED CACHE{CACHEVAR})
    if(DEFINED ENV{ENVAR})
if(COMMAND name)
    # determines if CMAKE command/fn/macro exists
if(POLICY name)
if(TARGET name)
if(TEST name)
if(value IN_LIST listName) # where lisName is a variable, not a string

#e.g. Conditional inclusion of library if CMAKE config is SET
option(BUILD_MYLIB "Enable building MyLib target")
if(BUILD_MYLIB)
    add_library(MyLib src1.cpp src2.cpp)
endif()


#[[
7.2 Looping
]]

#7.2.1 foreach()
foreach(v IN [LISTS listVar1 ...] [ITEMS item1 ...])
    #if BOTH LIST and ITEMS are used, ITEMS must follow LISTS
endforeach()
#ZIP allows you to pair data between multiple lists (uneven length => blanks)
foreach(i IN ZIP_LISTS iList jList)
    message("Vars:: ${i_0} ${i_1}")
endforeach()

foreach(i RANGE start stop [step])
endforeach()

#7.2.2 while()
while(condition)
endwhile()

# 7.2.3 interupting loops
break()
continue()
exit() # cmake 3.29 and up, but has conditions to work (see 20.5)

#[[
7.3 Best Practices
    * reduce instances of strings being interpreted as variables in conditional
    * copy result from if(x MATCHES regex) into a new local variable ASAP, since
      CMAKE_MATCH_<n> will be overwritten by next regex operation.
]]









