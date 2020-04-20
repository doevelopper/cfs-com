
#ifndef CFS_COM_DEMO_OPENDDS_DATAREADERLISTENERIMPL_HPP
#define CFS_COM_DEMO_OPENDDS_DATAREADERLISTENERIMPL_HPP

#include <ace/Global_Macros.h>
#include <dds/DdsDcpsSubscriptionC.h>
#include <dds/DCPS/LocalObject.h>
#include <dds/DCPS/Definitions.h>

#include <cfs/com/LoggingService.hpp>
class DataReaderListenerImpl
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    DataReaderListenerImpl() = default;
    DataReaderListenerImpl(const DataReaderListenerImpl&) = default;
    DataReaderListenerImpl(DataReaderListenerImpl&&) = default;
    DataReaderListenerImpl& operator=(const DataReaderListenerImpl&) = default;
    DataReaderListenerImpl& operator=(DataReaderListenerImpl&&) = default;
    virtual ~DataReaderListenerImpl() = default;
 protected:
 private:
};

#endif

