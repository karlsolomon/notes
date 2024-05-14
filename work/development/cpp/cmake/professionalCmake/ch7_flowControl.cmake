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









