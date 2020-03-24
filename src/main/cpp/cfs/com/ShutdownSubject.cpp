
#include <cfs/com/ShutdownSubject.hpp>

using namespace cfs::com;

ShutdownSubject::ShutdownSubject()
{

}

ShutdownSubject::~ShutdownSubject()
{

}

void ShutdownSubject::attach(Shutdown * t_observer)
{
    std::unique_lock<std::mutex> lock (m_mutex);
    m_observers.push_back(t_observer);
}

void ShutdownSubject::detach(Shutdown * t_observer)
{
    std::unique_lock<std::mutex> lock (m_mutex);
    m_observers.remove(t_observer);
}

void ShutdownSubject::notify()
{
    std::unique_lock<std::mutex> lock (m_mutex);
    for(auto observer: m_observers)
    {
        observer->on_shutdown();
    }
}
