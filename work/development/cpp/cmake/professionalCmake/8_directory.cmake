#[[
8.1 add_subdirectory()

cmake.org: This is useful for having CMake create makefiles or projects for a set of examples in a project. You would want CMake to generate makefiles or project files for all the examples at the same time, but you would not want them to show up in the top level project or be built each time make is run from the top.

]]

add_subdirectory(srcDir [binDir] [EXCLUDE_FROM_ALL] [SYSTEM])
# srcDir: can be rel or abs path binDir: required when srcDir is abs
# EXCLUDE_FROM_ALL: for some generators, doesn't act as expected SYSTEM:
# shouldn't normally be used

# 8.1.1 srcDir/binDir
#[[
    absolute paths only, indicators for debugging
    top context level
        CMAKE_SOURCE_DIR
        CMAKE_BINARY_DIR
    local context level
        CMAKE_CURRENT_SOURCE_DIR
        CMAKE_CURRENT_BINARY_DIR
]]

# 8.1.2 Scope Variables defined in child scope are not visible in parent scope
# Changes to a variable in child scope do not persist for parent scope Unset()
# var in child scope does not persist for parent scope Children can modify
# parent scope, but change isn't implemented until child returns e.g:

# CMakeLists.txt
set(a foo)
message("${a}")
add_subdirectory(subdir)
message("${a}")
# subdir/CMakeLists.txt
message("${a}")
set(a
    bar
    PARENT_SCOPE)
message("${a}")
# Outputs: foo foo foo bar

# to make change local and apply to parent scope do this:
set(a_local bar)
set(a
    ${a_local}
    PARENT_SCOPE)

#[[
8.2 include()

    Expects a file whereas add_subdirectory expects directory
    Generally fileType = '.cmake'
    No new/child variable scope

  cmake.org:
    If a module is specified instead of a file, the file with name
    <modulename>.cmake is searched first in CMAKE_MODULE_PATH, then in the
    CMake module directory.
]]
include(fileName [OPTIONAL] [RESULT_VAR myVar] [NO_POLICY_SCOPE])
include(module [OPTIONAL] [RESULT_VAR myVar] [NO_POLICY_SCOPE])
# debugging tools to diagnose current line (e.g. when an error is thrown)
message("src: ${CMAKE_CURRENT_SOURCE_DIR}")
message("bin: ${CMAKE_CURRENT_SOURCE_DIR}")
message("dir: ${CMAKE_CURRENT_LIST_DIR}")
message("file: ${CMAKE_CURRENT_LIST_FILE}")
message("line: ${CMAKE_CURRENT_LIST_LINE}")

#[[
8.3 Project-relative variables

better practice to use
projName_SOURCE_DIR projName_BINARY_DIR
than
CMAKE_SOURCE_DIR CMAKE_BINARY_DIR
since latter will change if this project is included as submodule of another project

    PROJECT_SOURCE_DIR: The source directory of the most recent call to project() in the current scope or any parent scope. The project name (i.e. the first argument given to the project() command) is not relevant.
    PROJECT_BINARY_DIR: The build directory corresponding to the source directory defined by PROJECT_SOURCE_DIR.
    projectName_SOURCE_DIR: The source directory of the most recent call to project(projectName) in the current scope or any parent scope. This is tied to a specific project name and therefore to a particular call to project().
    projectName_BINARY_DIR: The build directory corresponding to the source directory defined by projectName_SOURCE_DIR.
]]

#[[
8.4 Ending Process Early

see ErrHandling Project for example usage
]]
return() # stops processing current file (independent of include() or
         # add_subdirectory())
set(err 1)
set(dir ${CMAKE_CURRENT_LIST_DIR})
set(file ${CMAKE_CURRENT_LIST_FILE})
set(line ${CMAKE_CURRENT_LIST_LINE})
return(PROPAGATE err dir file line) # sets/propagates variables in parent
                                    # context.
include_guard() # used to prevent multiple processing of same cmake file

#[[
8.5 Best Practice

* Avoid using PROPAGATE except to return output of a function (breaks encapsulation pattern)
* Avoid using CMAKE_SOURCE_DIR and CMAKE_BINARY_DIR, these prevent refactoring into larger project
* prefer include_guard() to having #ifndef #define #endif everywhere

* only use project() where that directory and below can be considered a standalone project

]]
