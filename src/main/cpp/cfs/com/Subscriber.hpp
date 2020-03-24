
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
 protected:
 private:
};
}
#endif
