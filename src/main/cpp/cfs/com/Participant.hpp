
#ifndef CFS_COM_PARTICIPANT_HPP
#define CFS_COM_PARTICIPANT_HPP

namespace cfs::com
{
/*!
 * @brief Interface for creating domain participants
 */
class DomainParticipant
{
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

