
#ifndef CFS_COM_PUBLISHER_HPP
#define CFS_COM_PUBLISHER_HPP
namespace cfs::com
{
class Publisher
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    Publisher() = default;
    Publisher(const Publisher&) = default;
    Publisher(Publisher&&) = default;
    Publisher& operator=(const Publisher&) = default;
    Publisher& operator=(Publisher&&) = default;
    virtual ~Publisher() = default;
 protected:
 private:
};
}
#endif
