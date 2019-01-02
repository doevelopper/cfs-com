
#include <cfs/com/features/step_definitions/rti/Subscriber.hpp>
#include <cfs/com/features/step_definitions/rti/BuiltinPublicationListener.hpp>

using namespace dds::core;
using namespace rti::core::policy;
using namespace dds::domain;
using namespace dds::domain::qos;
using namespace dds::topic;
using namespace dds::sub;

using namespace cfs::com::rti;

Subscriber::Subscriber()
{
}

Subscriber::~Subscriber()
{

}

Subscriber::Subscriber(int domainId, int sampleCount)
{
    // Retrieve the Participant QoS, from USER_QOS_PROFILES.xml
    DomainParticipantQos participant_qos = QosProvider::Default()->
                                           participant_qos();

    // If you want to change the Participant's QoS programmatically rather than
    // using the XML file, uncomment the following lines.

    // participant_qos << DomainParticipantResourceLimits().
    //     type_code_max_serialized_length(3070);

    // Create a DomainParticipant.
    DomainParticipant participant(domain_id, participant_qos);

    // First get the builtin subscriber.
    Subscriber builtin_subscriber = dds::sub::builtin_subscriber(participant);

    // Then get builtin subscriber's DataReader for DataWriters.
    DataReader<PublicationBuiltinTopicData> publication_reader =
        rti::sub::find_datareader_by_topic_name< DataReader<PublicationBuiltinTopicData> >(
            builtin_subscriber,
            dds::topic::publication_topic_name());

    // Install our listener using ListenerBinder, a RAII that will take care
    // of setting it to NULL and deleting it.
    rti::core::ListenerBinder< DataReader<PublicationBuiltinTopicData> >
    publication_listener = rti::core::bind_and_manage_listener(
        publication_reader,  new BuiltinPublicationListener,
        dds::core::status::StatusMask::data_available());


    for (int count = 0; sample_count == 0 || count < sample_count; ++count)
    {
        rti::util::sleep(Duration(1));
    }

}
