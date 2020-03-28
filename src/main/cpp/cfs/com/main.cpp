
#include <cstdlib>
#include <iostream>
#include <cfs/com/LoggingService.hpp>
//#include <cfs/com/Initialize.hpp>

#include <cfs/com/demo/sensors/RandomGenerator.hpp>

int main(int argc, char *argv[])
{
    cfs::com::LoggingService * loggingService = new cfs::com::LoggingService();
    LOG4CXX_TRACE(log4cxx::Logger::getRootLogger(), "CFS cummunication bus layer!");
    (void)argc;
    (void)argv;

    cfs::com::demo::sensors::RandomGenerator generator;
    //std::cout<< "Numer: " << generator.random<int>(1, 50, false) << std::endl;

    if(loggingService)
    {
        delete loggingService;
        loggingService = nullptr;
    }

    return (EXIT_SUCCESS);
}
