
#ifndef CFS_COM_DATAREADER_HPP
#define CFS_COM_DATAREADER_HPP

#include <cfs/com/LoggingService.hpp>
#include <cfs/com/Subscriber.hpp>

namespace cfs::com
{
class DataReader
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:

    //using DataReaderPtr = std::shared_ptr<DDS::DataReader>;

    DataReader() = default;
    DataReader(const DataReader&) = default;
    DataReader(DataReader&&) = default;
    DataReader& operator=(const DataReader&) = default;
    DataReader& operator=(DataReader&&) = default;
    virtual ~DataReader() = default;

    //DataReaderPtr createDataReader();

 protected:
 private:
};
}
#endif

