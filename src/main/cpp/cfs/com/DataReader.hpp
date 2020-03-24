
#ifndef CFS_COM_DATAREADER_HPP
#define CFS_COM_DATAREADER_HPP

namespace cfs::com
{
class DataReader
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:

    DataReader() = default;
    DataReader(const DataReader&) = default;
    DataReader(DataReader&&) = default;
    DataReader& operator=(const DataReader&) = default;
    DataReader& operator=(DataReader&&) = default;
    virtual ~DataReader() = default;
 protected:
 private:
};
}
#endif

