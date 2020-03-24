
#ifndef CFS_COM_DATAWRITER_HPP
#define CFS_COM_DATAWRITER_HPP

namespace cfs::com
{
class DataWriter
{
	//LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    DataWriter() = default;
    DataWriter(const DataWriter&) = default;
    DataWriter(DataWriter&&) = default;
    DataWriter& operator=(const DataWriter&) = default;
    DataWriter& operator=(DataWriter&&) = default;
    virtual ~DataWriter() = default;
 protected:
 private:
};
}
#endif
