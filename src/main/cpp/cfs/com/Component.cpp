
#include <cfs/com/Component.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr Component::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Component"));
Component::Component(const std::string & t_name)
:  m_name(t_name)
,  m_isBlocking(true)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Component::~Component()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

std::string Component::name() const
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    return(m_name);
}

