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







