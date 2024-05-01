# 5.1 Testing

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

# 5.2 Installing
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

ijoi


