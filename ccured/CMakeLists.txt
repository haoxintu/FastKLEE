cmake_minimum_required(VERSION 3.4.3)

project(nescheck)
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LT_LLVM_INSTALL_DIR}")

message("LLVM STATUS:
  Definitions ${LLVM_DEFINITIONS}
  Includes    ${LLVM_INCLUDE_DIRS}
  Libraries   ${LLVM_LIBRARY_DIRS}
  Targets     ${LLVM_TARGETS_TO_BUILD}"
)


include_directories(${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})
add_definitions(${LLVM_DEFINITIONS})

include_directories("${CMAKE_SOURCE_DIR}/program-dependence-graph/SVF/include")
include_directories("${CMAKE_SOURCE_DIR}/program-dependence-graph/include")

# Compiler flag
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -Wall -fdiagnostics-color=always -Wno-everything")

# include_directories("include")
# include_directories("src")
# include_directories("sea-dsa/include")


set(CMAKE_CXX_STANDARD 14 CACHE STRING "")
add_library(ccured MODULE
    NesCheck.cpp
    AnalysisState.cpp
    AnalysisState.hpp
    #PTAWrapper.hh
    #PTAWrapper.cpp
    LLVMEssentials.hh
)

# target_link_libraries(nescheck PUBLIC "${CMAKE_SOURCE_DIR}/program-dependence-graph/build/libpdg_shared.a")
# target_link_libraries(nescheck PUBLIC "${CMAKE_SOURCE_DIR}/program-dependence-graph/SVF/Release-build/lib/libSvf.a")

target_link_libraries(ccured PUBLIC "${CMAKE_SOURCE_DIR}/program-dependence-graph/lib/libpdg_shared.a")
target_link_libraries(ccured PUBLIC "${CMAKE_SOURCE_DIR}/program-dependence-graph/lib/libSvf.a")

if(APPLE)
    set_target_properties(ccured PROPERTIES LINK_FLAGS "-undefined dynamic_lookup")
endif(APPLE)
