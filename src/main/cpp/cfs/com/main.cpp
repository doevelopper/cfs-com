
#include <cstdlib>
#include <iostream>
#include <cfs/com/demo/sensors/RandomGenerator.hpp>

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    cfs::com::demo::sensors::RandomGenerator generator;
    //std::cout<< "Numer: " << generator.random<int>(1, 50, false) << std::endl;
    return (EXIT_SUCCESS);
}
