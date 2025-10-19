# Require CMake 4.1.2
cmake_minimum_required(VERSION 4.1.2 FATAL_ERROR)

# Set the CUDA GPU compute capability
# Please refer to https://developer.nvidia.com/cuda-gpus
# If unsure, please keep the architecture as `native`
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
    set(CMAKE_CUDA_ARCHITECTURES native)
endif()

# Set language requirements
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)     # C++ requires 23
set(CMAKE_CUDA_STANDARD 20)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)    # CUDA requires 20

# Create the project and set the languages to CUDA, CXX (C++)
project(example_project LANGUAGES CUDA CXX)

# List the source files and name the executable
add_executable(example_project
    src/cuda_example.cu 
    src/main.cpp
)

# Required the CUDAToolKit
find_package(CUDAToolkit REQUIRED)

# Add a modules "library"
add_library(modules)

# Include modules
target_sources(modules
  PUBLIC FILE_SET
    CXX_MODULES FILES
      modules/module_example.cppm
)

# Add the include directory (contains both CUDA and CPP)
target_include_directories(example_project
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Link the CUDA runtime and the modules
target_link_libraries(example_project
    PRIVATE 
        CUDA::cudart                    # "#include <cuda_runtime.h>"
        modules                         # "import test_module"
)

# Compile Options
target_compile_options(example_project
    PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-O3>                                  # Optimize this very 'optimal' code...
        $<$<COMPILE_LANGUAGE:CUDA>:-Wno-deprecated-gpu-targets>         # Suppress the CUDA warnings
        # $<$<COMPILE_LANGUAGE:CUDA>:-allow-unsupported-compiler>       # If using an unsupported compiler version (e.g., g++-15)
)