add_executable(MyApp main.cpp) # Build Output is MyApp, console executable.
#[===[
[optional]
addExecutable(target [WIN32 | MACOSX_BUNDLE | MACOSX_FRAMEWORK] [EXCLUDE_FROM_ALL] name [targetname] source [source1 source2 ...)
]===]

# WIN32 - windows GUI application
# MACOSX_BUNDLE - MacOSX App
# EXCLUDE_FROM_ALL - Don't build this target, exclude from "ALL" target



add_library(targetName [SHARED | STATIC | MODULE] [EXCLUDE_FROM_ALL] source1 [source2 ...])) # Generates a library <targetName>.
# SHARED = DLL (.so)
# STATIC = (.a)
# MODULE = like dll, but optional
# typically leave this blank and configure using BUILD_SHARED_LIBS (true = build dll, false = static)

cmake -DBUILD_SHARED_LIBS:YES /path/to/source
# or
set(BUILD_SHARED_LIBS YES)

# LINKING
# PRIVATE - only uses linked lib in implementation, not interface.
# PUBLIC - uses linked lib in interface and implementation.
# INTERFACE - uses linked lib in interface, but not implementation.
target_link_libraries(targetName
    <PRIVATE|PUBLIC|INTERFACE> lib1 [lib2 ...]
    [<PRIVATE|PUBLIC|INTERFACE> lib3 [lib4 ...]]
)
