
#ifndef CFS_COM_SUBSCRIBERLISTENER_HPP
#define CFS_COM_SUBSCRIBERLISTENER_HPP
namespace cfs::com
{
class SubscriberListener
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    SubscriberListener() = default;
    SubscriberListener(const SubscriberListener&) = default;
    SubscriberListener(SubscriberListener&&) = default;
    SubscriberListener& operator=(const SubscriberListener&) = default;
    SubscriberListener& operator=(SubscriberListener&&) = default;
    virtual ~SubscriberListener() = default;
 protected:
 private:
};
}
#endif
