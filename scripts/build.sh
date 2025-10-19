#!/bin/bash
script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
root_dir="$(dirname "${script_dir}")"
build_dir="${root_dir}/build"

# Go to the projects root directory
cd "${root_dir}" || exit

# If builddir doesn't exist, setup
# mkdir -p "${build_dir}/gcm.cache"
mkdir -p "${build_dir}"
cd "${build_dir}" || exit

# Come back to this when g++-15 supports std modules?
# g++ -std=c++23 -fmodules -x c++-system-header iostream
# g++ -std=c++23 -fmodules -x c++-system-header print
# g++ -std=c++23 -fmodules -x c++-system-header string
# g++ -std=c++23 -fmodules -x c++-system-header vector
cmake -G Ninja ..

ninja