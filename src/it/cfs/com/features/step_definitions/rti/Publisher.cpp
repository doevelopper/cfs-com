
#include <src/it/cfs/com/features/step_definitions/rti/Publisher.hpp>

using namespace dds::core;
using namespace rti::core::policy;
using namespace dds::domain;
using namespace dds::domain::qos;
using namespace dds::topic;
using namespace dds::pub;

Publisher::Publisher(int domainId, int sampleCount)
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

    // Create a Topic -- and automatically register the type
    Topic<msg> topic(participant, "Example msg");

    // Create a DataWriter with default Qos (Publisher created in-line)
    DataWriter<msg> writer(Publisher(participant), topic);

    msg sample;
    for (int count = 0; count < sample_count || sample_count == 0; count++)
    {
        // Update sample and send it.
        std::cout << "Writing msg, count " << count << std::endl;
        sample.count(count);
        writer.write(sample);

        rti::util::sleep(Duration(4));
    }
}
