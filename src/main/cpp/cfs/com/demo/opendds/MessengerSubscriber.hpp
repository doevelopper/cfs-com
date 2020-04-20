#ifndef CFS_COM_DEMO_OPENDDS_MESSENGERSUBSCRIBER_HPP
#define CFS_COM_DEMO_OPENDDS_MESSENGERSUBSCRIBER_HPP

#include <cfs/com/LoggingService.hpp>

#include <dds/DdsDcpsInfrastructureC.h>
#include <dds/DdsDcpsSubscriptionC.h>

#include <dds/DCPS/Marked_Default_Qos.h>
#include <dds/DCPS/Service_Participant.h>
#include <dds/DCPS/WaitSet.h>

#include <dds/DCPS/StaticIncludes.h>
#ifdef ACE_AS_STATIC_LIBS
#  include <dds/DCPS/RTPS/RtpsDiscovery.h>
#  include <dds/DCPS/transport/rtps_udp/RtpsUdp.h>
#endif

namespace cfs::com::demo::opendds
{
class MessengerSubscriber
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    MessengerSubscriber() = default;
    MessengerSubscriber(const MessengerSubscriber&) = default;
    MessengerSubscriber(MessengerSubscriber&&) = default;
    MessengerSubscriber& operator=(const MessengerSubscriber&) = default;
    MessengerSubscriber& operator=(MessengerSubscriber&&) = default;
    virtual ~MessengerSubscriber() = default;
 protected:
 private:
};
}

#endif

