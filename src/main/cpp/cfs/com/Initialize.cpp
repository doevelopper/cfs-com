#include <stdexcept>
#include <cfs/com/Initialize.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr Initialize::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Initialize"));

Initialize::Initialize(int* argc, char** argv, bool flags)
{
    //phases(cfs::com::Phases::INIT);
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Initialize::~Initialize()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void Initialize::phases(const cfs::com::Phase & t_newPhase)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    Phase curphase = phase();
    if (curphase == cfs::com::Phase::SYSTEM_HALT || int(t_newPhase) - int(t_newPhase) != 1)
    {
        //LOG4CXX_ERROR  unexpected phase transition
    }
    //m_phase.store(t_newPhase, std::memory_order_relaxed);
}

const cfs::com::Phase & Initialize::phase() const noexcept
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

     return (m_phase.load(std::memory_order_relaxed));
}


void Initialize::phases()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

