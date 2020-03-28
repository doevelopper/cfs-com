
#ifndef CFS_COM_PUBLISHERLITENER_HPP
#define CFS_COM_PUBLISHERLITENER_HPP

#include <cfs/com/LoggingService.hpp>

namespace cfs::com
{
class PublisherListener
{

	LOG4CXX_DECLARE_STATIC_LOGGER

 public:
    PublisherListener() = default;
    PublisherListener(const PublisherListener&) = default;
    PublisherListener(PublisherListener&&) = default;
    PublisherListener& operator=(const PublisherListener&) = default;
    PublisherListener& operator=(PublisherListener&&) = default;
    virtual ~PublisherListener() = default;
 protected:
 private:
};
}
#endif

