
#ifndef CFS_COM_SUBSCRIBER_HPP
#define CFS_COM_SUBSCRIBER_HPP
namespace cfs::com
{
class Subscriber
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    Subscriber() = default;
    Subscriber(const Subscriber&) = default;
    Subscriber(Subscriber&&) = default;
    Subscriber& operator=(const Subscriber&) = default;
    Subscriber& operator=(Subscriber&&) = default;
    virtual ~Subscriber() = default;
/*
    using SubscriberPtr = std::shared_ptr<DDS::Subscriber> SubscriberPtr;
SubscriberPtr createSubscriber
   (
   DomainParticipantPtr participantPtr
   );
SubscriberPtr createSubscriber
   (
   DomainParticipantPtr      participantPtr,
   const DDS::SubscriberQos& qos
   );
SubscriberPtr createSubscriber
   (
   DomainParticipantPtr      participantPtr,
   const DDS::SubscriberQos& qos,
   DDS::SubscriberListener*  pListener,
   DDS::StatusMask           mask
   );
void getDefaultSubscriberQos
   (
   DomainParticipantPtr participantPtr,
   DDS::SubscriberQos&  qos
   );
*/
 protected:
 private:
};
}
#endif
