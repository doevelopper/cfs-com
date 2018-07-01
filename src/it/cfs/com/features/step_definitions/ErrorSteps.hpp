
#ifndef CFS_COM_FEATURES_STEP_DEFINITIONS_ERROR_STEPS_HPP
#define CFS_COM_FEATURES_STEP_DEFINITIONS_ERROR_STEPS_HPP

#include <gtest/gtest.h>
#include <cucumber-cpp/autodetect.hpp>
#include <cstdint>

#include <cfs/com/Error.hpp>

// using namespace Allow step definition in multiple source files.
namespace cfs::com::it::e
{
    struct ErrorContext
    {
        cfs::com::Error error;
        std::uint32_t errorCode;
        std::string message;

    };
}
#endif
