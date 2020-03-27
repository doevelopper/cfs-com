
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
/*
    usin DataWriterPtr = std::shared_ptr<DDS::DataWriter>;
DataWriterPtr createDataWriter
   (
   PublisherPtr publisherPtr,
   TopicPtr     topicPtr
   );
DataWriterPtr createDataWriter
   (
   PublisherPtr              publisherPtr,
   TopicPtr                  topicPtr,
   const DDS::DataWriterQos& qos
   );
DataWriterPtr createDataWriter
   (
   PublisherPtr              publisherPtr,
   TopicPtr                  topicPtr,
   const DDS::DataWriterQos& qos,
   DDS::DataWriterListener*  pListener,
   DDS::StatusMask           mask
   );
void getDefaultDataWriterQos
   (
   PublisherPtr        publisherPtr,
   DDS::DataWriterQos& qos
   );
template <typename TraitsType>
typename boost::shared_ptr<typename TraitsType::DataWriterType> narrow
   (
   DataWriterPtr dwPtr
   );
template <typename TraitsType>
typename boost::shared_ptr<typename TraitsType::DataWriterType> createDataWriter
   (
   PublisherPtr publisherPtr,
   TopicPtr     topicPtr
   );
template <typename TraitsType>
typename boost::shared_ptr<typename TraitsType::DataWriterType> createDataWriter
   (
   PublisherPtr              publisherPtr,
   TopicPtr                  topicPtr,
   const DDS::DataWriterQos& qos
   );
template <typename TraitsType>
typename boost::shared_ptr<typename TraitsType::DataWriterType> createDataWriter
   (
   PublisherPtr              publisherPtr,
   TopicPtr                  topicPtr,
   const DDS::DataWriterQos& qos,
   DDS::DataWriterListener*  pListener,
   DDS::StatusMask           mask
   );
*/
 protected:
 private:
};
}
#endif
