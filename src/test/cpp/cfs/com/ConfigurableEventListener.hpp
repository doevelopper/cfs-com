#ifndef CFS_COM_CONFIGURABLEEVENTLISTENER_HPP
#define CFS_COM_CONFIGURABLEEVENTLISTENER_HPP

#include <iostream>
#include <string>

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include <cfs/com/LoggingService.hpp>

namespace cfs::com::test
{

class ConfigurableEventListener
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    ConfigurableEventListener() = default;
    ConfigurableEventListener(const ConfigurableEventListener&) = default;
    ConfigurableEventListener(ConfigurableEventListener&&) = default;
    ConfigurableEventListener& operator=(const ConfigurableEventListener&) = default;
    ConfigurableEventListener& operator=(ConfigurableEventListener&&) = default;
    virtual ~ConfigurableEventListener() = default;
 protected:
 private:
};

}

#endif

