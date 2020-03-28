
#include <cfs/com/Shutdown.hpp>
#include <cfs/com/ShutdownSubject.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr Shutdown::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Shutdown"));

Shutdown::Shutdown(ShutdownSubject * subject)
:   m_subject(subject)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    if(subject != nullptr)
    {
        add(subject);
    }

}

Shutdown::~Shutdown()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
   if(m_subject != nullptr)
   {
       remove(m_subject);
   }
}

void Shutdown::add(ShutdownSubject * t_subject)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    m_subject = t_subject;
    m_subject->attach(this);
}

void Shutdown::remove(ShutdownSubject * t_subject)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    m_subject->detach(this);

}
