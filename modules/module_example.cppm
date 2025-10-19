module;

#include <string>
#include <iostream>
#include <print>

export module module_example;

namespace module_example
{
    constexpr std::string location = "The Test Module";

    export void hello()
    {
        std::print("Hello from: {}\n", location);
    }
}