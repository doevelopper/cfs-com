#include <stdexcept>
#include <cfs/com/Initialize.hpp>

using namespace cfs::com;

Initialize::Initialize(int* argc, char** argv, bool flags)
{
    //phases(cfs::com::Phases::INIT);
}

Initialize::~Initialize()
{

}

void Initialize::phases(const cfs::com::Phase & t_newPhase)
{
    Phase curphase = phase();
    if (curphase == cfs::com::Phase::SYSTEM_HALT || int(t_newPhase) - int(t_newPhase) != 1)
    {
        //LOG4CXX_ERROR  unexpected phase transition
    }
    m_phase.store(t_newPhase, std::memory_order_relaxed);
}

const cfs::com::Phase & Initialize::phase() const noexcept
{
     return (m_phase.load(std::memory_order_relaxed));
}


void Initialize::phases()
{
}

