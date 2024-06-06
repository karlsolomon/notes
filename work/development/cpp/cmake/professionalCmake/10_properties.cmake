#[[
10.1 General Property Commands

Properties are always attached to a specific entry:
    directory, target, sourcefile, test case, cache variable, top-level build
Properties != Variables

Most of the specific properties are just syntactic sugar on top of set_property and get_property
]]

# set_property
#[[
set property/value options:
    GLOBAL
    DIRECTORY [dir] => omission of [dir] means current source dir is used
    TARGET targets...
    SOURCE sources...
    INSTALL files...
    TEST tests...
    CACHE vars...
]]
set_property(entity [APPEND | APPEND_STRING] PROPERTY property values...)
# APPEND/APPEND_STRING/<none>
set_property(MyApp SOURCE main.cpp) # <none> will overwrite property with value
set_property(MyApp APPEND SOURCE src1.c) # APPEND will add value to end of list
set_property(MyApp APPEND_STRING pp) # APPEND_STRING will extend string of last item in list
# ends with SOURCE = {main.cpp;src1.cpp}

# get_property
#[[
get property options:
    GLOBAL
    DIRECTORY [dir]
    TARGET target
    SOURCE source
    INSTALL file
    TEST test
    CACHE var
    VARIABLE
]]
get_property(result entity PROPERTY property [DEFINED | SET | BRIEF_DOCS | FULL_DOCS])
# DEFINED returns bool indicating if named property is defined SET returns bool indicating if named
# property is set/non-empty BRIEF_DOCS returns brief docstring or NOTFOUND if none is set FULL_DOCS
# returns full docstring or NOTFOUND if none is set

#[[
define_property(
    entityType
    PROPERTY propertyName
    [INHERITED]
    [BRIEF_DOCS briefDoc [moreBriefDocs...].]
    [FULL_DOCS fullDoc [moreFullDocs...].]
    [INITIALIZE_FROM_VARIABLE variableName]
)
]]

#[[
10.2 Global Properties
]]
get_cmake_property(res global_property)
#[[
global_property options:
- VARIABLES
- CACHE_VARIABLES
- COMMANDS -- case insensitive
- MACROS -- subset of COMMANDS
- COMPONENTS
]]

#[[
10.3 Directory Properties
]]
# set_directory_properties is a write-only modifier. There is no append option. So to append you'd
# have to get_property, then append to local variable, then set_properties
set_directory_properties(PROPERTIES prop1 val1 [prop2 val2] ...)
get_directory_property(result [DIRECTORY dir] PROPERTY property)

#[[
10.4 Target Properties

These actually have pretty big impact on how targets are built. This is where the rubber meets the
road.
- Flags, Source Files, Bin locations, intermediate files (.o), etc.
]]

# set requires lists be provided in string form "a;b;c"
set_target_properties(
    target1 [target2...] PROPERTIES propertyName1 value1 [propertyName2 value2] ...
)
get_target_property(resultVar target propertyName)

#[[
10.5 Source Properties
Can modify compiler flags for specific files. (pretty dope tbh, but hopefully don't need to use)
]]

set_source_files_properties(
    sources... [DIRECTORY dirs...] [TARGET_DIRECTORY targets...]
    PROPERTIES propertyName1 value1 [propertyName2 value2] ...
)

get_source_file_property(resultVar source [DIRECTORY dir | TARGET_DIRECTORY target] propertyName)

add_executable(MyApp small.cpp big.cpp tall.cpp thin.cpp)
set_source_files_properties(big.cpp PROPERTIES SKIP_UNITY_BUILD_INCLUSION YES) # Example Usage

#[[
10.6 Cache Variable Properties

These work a bit differently than above since they're targeted to be used with ccmake GUI.
See Section 6.3 "Cache Variables" for details
]]

#[[
10.7 Test Properties
]]
set_tests_properties(
    test1 [test2...] [DIRECTORY dir] PROPERTIES propertyName1 value1 [propertyName2 value2] ...
)
get_test_property(test propertyName [DIRECTORY dir] resultVar)

#[[
10.8 Install Properties

Typically not needed by most projects
]]
