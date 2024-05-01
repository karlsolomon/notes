cmake_minimum_required(VERSION 3.29)
project(CPPTest LANGUAGES CXX)
#set(CMAKE_C_FLAGS_INIT "-I/usr/include")
set(CMAKE_CXX_STANDARD 17)
find_package(gsl REQUIRED)
add_executable(Main main.cpp)
target_link_libraries(Main PRIVATE gsl::gsl)

#g++ -I/usr/include -L/usr/lib main.cpp -o main -lgsl -lgslcblas -lm
