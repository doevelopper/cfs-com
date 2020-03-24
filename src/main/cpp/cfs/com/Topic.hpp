
#ifndef CFS_COM_TOPIC_HPP
#define CFS_COM_TOPIC_HPP
namespace cfs::com
{
class Topic
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    Topic() = default;
    Topic(const Topic&) = default;
    Topic(Topic&&) = default;
    Topic& operator=(const Topic&) = default;
    Topic& operator=(Topic&&) = default;
    virtual ~Topic() = default;
 protected:
 private:
};
}
#endif
