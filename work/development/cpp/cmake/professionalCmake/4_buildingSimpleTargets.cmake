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


#Example with multiple libraries when we are creating the library from source
add_library(Collector src1.cpp)
add_library(Algo src2.cpp)
add_library(Engine src3.cpp)
add_library(Ui src4.cpp)
add_executable(MyApp main.cpp)
target_link_libraries(
    Collector
    PUBLIC Ui
    PRIVATE Algo Engine)

target_link_libraries(MyApp PRIVATE Collector)

#Example with prebuilt libraries
#g++ -I/usr/include -L/usr/lib main.cpp -o Main -lgsl -lgslcblas -lm
set(CMAKE_C_FLAGS_INIT "-I/usr/include")
add_executable(Main main.cpp)
target_link_libraries(Main -lgsl -lgslcblas -lm) #libgsl.so in /usr/lib


