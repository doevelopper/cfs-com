
#ifndef CFS_COM_PARTICIPANTFACTORY_HPP
#define CFS_COM_PARTICIPANTFACTORY_HPP

#include <memory>

namespace cfs::com
{
    using std::shared_ptr<DDS::DomainParticipantFactoryInterface> DomainParticipantFactoryPtr;
    using std::shared_ptr<DDS::DomainParticipant> DomainParticipantPtr;
    using std::shared_ptr<DDS::Topic> TopicPtr;
    using std::shared_ptr<DDS::ContentFilteredTopic> ContentFilteredTopicPtr;
    using std::shared_ptr<DDS::Publisher> PublisherPtr;
    using std::shared_ptr<DDS::Subscriber> SubscriberPtr;
    using std::shared_ptr<DDS::DataWriter> DataWriterPtr;
    using std::shared_ptr<DDS::DataReader> DataReaderPtr;
    using std::shared_ptr<DDS::ReadCondition> ReadConditionPtr;
    using std::shared_ptr<DDS::WaitSet> WaitSetPtr;
    using std::shared_ptr<DDS::DataReaderListener> ListenerPtr;

/*!
 * @brief Interface for getting the domain participant factory.
 */

    class ParticipantFactory
    {

    public:

        ParticipantFactory();
        ~ParticipantFactory();

        DomainParticipantFactoryPtr participantFactory();

    protected:

    private:

    };

}

#endif
