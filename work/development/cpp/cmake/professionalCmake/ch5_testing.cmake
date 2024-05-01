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


