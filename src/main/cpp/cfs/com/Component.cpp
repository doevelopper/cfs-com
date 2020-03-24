
#include <cfs/com/Component.hpp>

using namespace cfs::com;

Component::Component(const std::string & t_name)
:  m_name(t_name)
,  m_isBlocking(true)
{

}

Component::~Component()
{

}

std::string Component::name() const
{
    return(m_name);
}
