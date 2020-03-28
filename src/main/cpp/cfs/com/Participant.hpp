
#ifndef CFS_COM_PARTICIPANT_HPP
#define CFS_COM_PARTICIPANT_HPP
#include <cfs/com/LoggingService.hpp>
namespace cfs::com
{
/*!
 * @brief Interface for creating domain participants
 */

    class DomainParticipant
    {

        LOG4CXX_DECLARE_STATIC_LOGGER

    public:

        DomainParticipantPtr createParticipant (
            ::DomainParticipantFactoryPtr factoryPtr,
            DDS::DomainId_t domainId );

        DomainParticipantPtr createParticipant(
            ::DomainParticipantFactoryPtr factoryPtr,
            DDS::DomainId_t domainId,
            const DDS::DomainParticipantQos&  qos
            );

        DomainParticipantPtr createParticipant(
            ::DomainParticipantFactoryPtr factoryPtr,
            DDS::DomainId_t domainId,
            const DDS::DomainParticipantQos& qos,
            DDS::DomainParticipantListener* pListener,
            DDS::StatusMask mask
            );
    }

}
#endif
