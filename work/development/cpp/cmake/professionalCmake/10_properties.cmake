#[[
10.1 General Property Commands

Properties are always attached to a specific entry:
    directory, target, sourcefile, test case, cache variable, top-level build
Properties != Variables
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
