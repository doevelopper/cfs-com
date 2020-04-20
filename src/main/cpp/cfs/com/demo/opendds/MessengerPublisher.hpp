
#ifndef CFS_COM_DEMO_OPENDDS_MESSENGERPUBLISHER_HPP
#define CFS_COM_DEMO_OPENDDS_MESSENGERPUBLISHER_HPP

#include <cfs/com/LoggingService.hpp>
#include <dds/DdsDcpsInfrastructureC.h>
#include <dds/DdsDcpsPublicationC.h>

#include <dds/DCPS/Marked_Default_Qos.h>
#include <dds/DCPS/Service_Participant.h>
#include <dds/DCPS/WaitSet.h>

#include <dds/DCPS/StaticIncludes.h>
#ifdef ACE_AS_STATIC_LIBS
#  include <dds/DCPS/RTPS/RtpsDiscovery.h>
#  include <dds/DCPS/transport/rtps_udp/RtpsUdp.h>
#endif

//#include <idl/cfs/com/demo/msg/MessengerTypeSupportImpl.h>
#include <MessengerTypeSupportImpl.h>

namespace cfs::com::demo::opendds
{
class MessengerPublisher
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    MessengerPublisher() = default;
    MessengerPublisher(const MessengerPublisher&) = default;
    MessengerPublisher(MessengerPublisher&&) = default;
    MessengerPublisher& operator=(const MessengerPublisher&) = default;
    MessengerPublisher& operator=(MessengerPublisher&&) = default;
    virtual ~MessengerPublisher() = default;
 protected:
 private:
};
}
#endif

