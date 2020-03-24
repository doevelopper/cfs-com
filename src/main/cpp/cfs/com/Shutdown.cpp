
#include <cfs/com/Shutdown.hpp>
#include <cfs/com/ShutdownSubject.hpp>

using namespace cfs::com;

Shutdown::Shutdown(ShutdownSubject * subject)
:   m_subject(subject)
{
    if(subject != nullptr)
    {
        add(subject);
    }

}

Shutdown::~Shutdown()
{
   if(m_subject != nullptr)
   {
       remove(m_subject);
   }
}

void Shutdown::add(ShutdownSubject * t_subject)
{
    m_subject = t_subject;
    m_subject->attach(this);
}

void Shutdown::remove(ShutdownSubject * t_subject)
{
    m_subject->detach(this);

}
