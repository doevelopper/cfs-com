
#include <cfs/com/ShutdownSubject.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr ShutdownSubject::logger = log4cxx::Logger::getLogger(std::string("cfs.com.ShutdownSubject"));
ShutdownSubject::ShutdownSubject()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

ShutdownSubject::~ShutdownSubject()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void ShutdownSubject::attach(Shutdown * t_observer)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    std::unique_lock<std::mutex> lock (m_mutex);
    m_observers.push_back(t_observer);
}

void ShutdownSubject::detach(Shutdown * t_observer)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    std::unique_lock<std::mutex> lock (m_mutex);
    m_observers.remove(t_observer);
}

void ShutdownSubject::notify()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    std::unique_lock<std::mutex> lock (m_mutex);
    for(auto observer: m_observers)
    {
        observer->on_shutdown();
    }
}
