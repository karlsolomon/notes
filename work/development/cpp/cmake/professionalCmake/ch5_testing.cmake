#[[
5.1 TESTING
]]

cmake_minimum_required(VERSION 3.29)
project(MyProj VERSION 4.7.2)
enable_testing() # creates ctest input file -- generally just post project()
add_executable(testSomething testSomething.cpp)
add_test(NAME SomethingWorks COMMAND testSomething)
add_test(NAME ExternalTool COMMAND /path/to/tool someArg moreArgs)

#[[ Command line to generate a debug project and run tests
mkdir build
cb build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug ../source
cmake --build .
ctest # could do something like "ctest -j 16" (j == parallel) if many tests

    or

mkdir build
cd build
cmake -G "Ninja Multi-Config" ../source
cmake --build . --config Debug
ctest -C Debug #-C is same as --build-config
]]

#[[
5.2 INSTALLING
]]
# Install copies files from build directory to install location.
cmake_minimum_required(VERSION 3.14)
project(MyProj VERSION 4.7.2)
add_executable(MyApp ...)
add_library(AlgoRuntime SHARED ...)
add_library(AlgoSDK STATIC ...)
install(TARGETS MyApp AlgoRuntime AlgoSDK) # assumes location based on OS

    #Headers
        #OLD 1
install(FILES a.h b.h DESTINATION include/myproj)
install(DIRECTORY headers/myproj DESTINATION include)
        #OLD 2
install(DIRECTORY headers/ DESTINATION include/myproj)
        #NEW (2.23) - using "File sets"
add_library(AlgoSDK ...)
target_sources(AlgoSDK
    PUBLIC
        FILE_SET api
        TYPE HEADERS
        BASE_DIRS headers
        FILES
            headers/myproj/sdk.h
            headers/myproj/sdk_version.h
)
install(TARGETS AlgoSDK FILE_SET api)
    # FILE_SETS assume the following structure:
|>BASE_DIR
  |>include
    |>myproj
      ->sdk.h
      ->sdk_version.h

#[[ To 1. configure 2. build 3. install a project:
    mkdir build
    cd build
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug ../source
    cmake --build .
    cmake --install . --prefix <buildDir>
]]

#[[
5.3 PACKAGING
]]
# cpack = project ==> zip
# performs multiple cmake --install commands
# Basic Example:
cmake_minimum_required(VERSION 3.14)
projet(MyProj VERSION 4.7.2)
add_executable(MyApp ...)
add_library(AlgoRuntime SHARED ...)
add_library(AlgoSDK STATIC ...)
install(TARGETS MyApp AlgoRuntime AlgoSDK)

#proj-specific
set(CPACK_PACKAGE_NAME MyProj)
set(CPACK_PACKAGE_VENDOR MyCompany)
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example project") # surround vars with quotes if contain spaces

#Typically same ∀ projects
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
set(CPACK_VERBATIM_VARIABLES TRUE)

#writes out input file for cpack
include(CPack)


#[[
Configure, Build, and Package a project
    mkdir build
    cd build
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ../sourcecmake --build .
    cpack -G "ZIP;WIX"
common to use Release when packaging
]]




