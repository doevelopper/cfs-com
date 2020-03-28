
#ifndef CFS_COM_TOPIC_HPP
#define CFS_COM_TOPIC_HPP

#include <cfs/com/LoggingService.hpp>

namespace cfs::com
{

    //using TopicPtr = std::shared_ptr<DDS::Topic>;

    class Topic
    {
	    LOG4CXX_DECLARE_STATIC_LOGGER
    public:
        Topic() = default;
        Topic(const Topic&) = default;
        Topic(Topic&&) = default;
        Topic& operator=(const Topic&) = default;
        Topic& operator=(Topic&&) = default;
        virtual ~Topic() = default;
/*
        TopicPtr createTopic(DomainParticipantPtr participantPtr,
                const char*          topicName,
                const char*          typeName);
        TopicPtr createTopic(DomainParticipantPtr participantPtr,
                const char*          topicName,
                const char*          typeName,
                const DDS::TopicQos& qos);
        TopicPtr createTopic(DomainParticipantPtr participantPtr,
                const char*          topicName,
                const char*          typeName,
                const DDS::TopicQos& qos,
                DDS::TopicListener*  pListener,
                DDS::StatusMask      mask);
*/
    protected:
    private:
    };
}
#endif
