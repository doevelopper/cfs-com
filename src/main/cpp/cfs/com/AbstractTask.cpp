
#include <cfs/com/AbstractTask.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr AbstractTask::logger = log4cxx::Logger::getLogger(std::string("cfs.com.AbstractTask"));
AbstractTask::AbstractTask(Component * component)
:	Shutdown(component)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

AbstractTask::~AbstractTask()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void AbstractTask::on_shutdown()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    this->stop();
}

