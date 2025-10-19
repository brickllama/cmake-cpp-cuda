#include "../include/cuda_example.cuh"
import module_example;

/**
 * @brief Program entry
 */
int main()
{
    HelloGpu();
    module_example::hello();
    return 0;
}