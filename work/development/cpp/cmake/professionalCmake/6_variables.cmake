#[[
6.1 Setting Variables
]]

set(varName value [PARENT_SCOPE])
#all variables are treated as strings
set(myVar a b c) # => "a;b;c"
set(myVar a;b;c) # => "a;b;c"
set(myVar "a b c") # => "a b c"
set(myVar a b;c) # => "a;b;c"
set(myVar a "b c") # => "a;b c"

#undefined variables are treated as empty strings. UNDEFINED VARIABLES DO NOT THROW ERRORS.
# Need to use "cmake --warn-uninitialized" to catch

# strings can be multiple lines
set(multiLine "First line
Second line")
# or lua-syntax where you don't need to escape quotes
set(shellScript [[
#!/bin/bash

[[ -n "${USER}"]] && echo "Have USER"
]=])

#unset/clear variable
set(var "a")
set(var) #clears var
unset(var) #clears var

#[[
6.2 Environment Variables
]]
set(ENV{PATH} "$ENV{PATH}:opt/miniconda3/") # only modifies PATH for current CMAKE scope. Not easily detectible at build time and doesn't persist, so kinda bad style to do this.

#[[
6.3 Cache Variables

These persist between CMAKE runs.
Treated as configs/toggle options to enable/disable different parts of the build.
]]
set(varName value... CACHE type "docstring" [FORCE]) # only overwrites CACHE if FORCE is set
#type and docstring are mandatory
#[[
types = {
    OPTIONAL,
    INTERNAL,
    FILEPATH,
    PATH,
    STRING,
    BOOL,
    FILE,
    UNINITIALIZED
}
]]
#Specifically for BOOL type:
option(boolVar "docstring") # same as OFF
option(boolVar "docstring" OFF)
option(boolVar "docstring" ON)

# it is possible to have same named CACHE and normal vars. In that case normal var takes precedence. E.g.
set(a "a")
set(a "A" CACHE STRING "caps")
echo a # => "a"


#Masking/Unmasking CACHE
set(foo "bar" CACHE STRING "cachedval")
unset(foo)
echo foo # => "bar" (unmasks CACHE)
set(foo)
echo foo # => "bar" (unmasks CACHE)
set(foo "")
echo foo # => "" (explicitly sets foo to empty string)

# Can explicitly specify to read out cache value with following, however this is bad practice for production code. Mainly recommended only for debugging.
$CACHE{foo}


#Cmd line can be used to set CACHE variables, but here it is possible to not set initial value and/or docstring
# cmake -D foo:type=STRING ...
#use -D to set multiple variables
#[[
    cmake -D foo:BOOL=OFF -D bar:STRING="A"
    cmake -D "bar:STRING: spaces" ...
    cmake -D hiddenVal=mystery ...
]]


# Can also remove (multiple) cache variables via cmd line with -U. ?* wildcards supported
# cmake -U "help*" -U foo ...

# Can define a set of valid inputs for multivariable types (e.g. string)
set(STOP_LIGHT Red CACHE STRING "intersection control")
set_property(CACHE STOP_LIGHT PROPERTY STRINGS Red Green Yellow)


#[[
6.4 Scope Blocks
]]
#CACHE variables are global in scope
set(varA "a")
set(varB "b")
block()
    set(varA "A")
    set(varB "B")
    set(varC "C")
    echo varA varB varC # => "A B C"
endblock()
echo varA varB varC # => "a b"

set(x 1)
block()
    set(x 2 PARENT_SCOPE)
    echo x # => 2
endblock()

set(x 1)
set(y 5)
block(PROPAGATE x) # ==> keeps x outside of block
    set(x 2)
    set(y 2)
endblock()
echo x # => 2
echo y # => ""/undefined

#[[
6.5 Printing Variable Values
]]
set(y World)
set(x Hello)
message("Hello ${x}!\n${y} "
"World!") # "Hello World!\nHello World!"

#[[
6.6 String Handling
    outIdx:
        0-indexed
        REVERSE gets last occurrence, else first
        -1 if not found
]]
string(FIND searchString subString outIdx [REVERSE])
string(REPLACE matchString replaceWith outStr input...)
string(REGEX [MATCH|MATCHALL] regex outStr input...)
string(REGEX REPLACE regex replaceWith outStr input...)
#LENGTH counts bytes, not characters
string([LENGTH|TOLOWER|TOUPPER|STRIP] input output)

#[[
6.7 Lists
]]
list(LENGTH listVar outVar) # gets the length of 'listVar' and writes to 'outVar'
list(GET listVar index [index...] outVar)
list(INSERT listVar index item [item...])
list(APPEND listVar item [item...])
list(PREPEND listVar item [item...])
list(FIND listVar item outVar) # -1 if not found
list(REMOVE_ITEM listVar value [value...]) # removes all instances of one or more values
list(REMOVE_AT listVar index [index...])
list(REMOVE_DUPLICATES listVar)
list(POP_FRONT myList [outVar1 [outVar2...]]) # if outVar is not specified, it is just removed and discarded
list(POP_BACK myList [outVar1 [outVar2...]])
list(REVERSE myList)
list(SORT myList [COMPARE method] [CASE case] [ORDER order])
    # method: {STRING(default),FILE_BASENAME,NATURAL}
    # case: {SENSITIVE,INSENSITIVE}
    # order: {ASCENDING,DESCENDING}

# Example
set(myList a b c) # creates list "a;b;c"
list(LENGTH myList outVar) # gets 3
list(GET myList 2 1 outVar) # gets "c;b"
list(INSERT myList 2 X Y Z)
message("myList: ${myList}") # gets "a;b;X;Y;Z;c"
list(APPEND myList d e f)
message("myList: ${myList}") # gets "a;b;X;Y;Z;c;d;e;f"
list(PREPEND myList P Q R)
message("myList: ${myList}") # gets "P;Q;R;a;b;X;Y;Z;c;d;e;f"


#[[
6.8 Math
]]
math(EXPR outVar expression [OUTPUT_FORMAT format])
set(x 3)
set(y 7)
math(EXPR zDec "(${x}+${y}) * 2")
math(EXPR zHEX "(${x}+${y}) * 2" OUTPUT_FORMAT HEXADECIMAL)
message("dec = ${zDec}, hex = ${zHEX}") # 20, 0x14


#[[
6.9 Best Practices
        Prefer cache variables. This makes control via CMAKE GUI easy.
        Avoid environment variables except maybe PATH since that is ubiquitous.
        Group like/related cache variables with prefix_varName since GUI sorts alphabetically.
        Avoid using same name for Cache and normal variables, new devs easily confused by behavior.
]]
















