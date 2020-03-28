
#include <cfs/com/Task.hpp>

using namespace cfs::com;
log4cxx::LoggerPtr Task::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Task"));

Task::Task(Component *component)
:	AbstractTask(component)
,	m_cancelled(false)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Task::~Task()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

bool Task::isCanceled()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
	return (m_cancelled);
}

void Task::sleep(const Duration &duration)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
	std::this_thread::sleep_for(duration);
}

int Task::start()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

	if(m_asyncHandle.valid())
    {
		// thread already running
		return -1;
	}
	m_cancelled = false;
	m_asyncHandle = std::async(std::launch::async, &Task::execution, this);

	return 0;
}

int Task::stop(const bool wait)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
  	int result = 0;
	m_cancelled = true;

    if(m_asyncHandle.valid() && wait)
    {
        result = m_asyncHandle.get();
    }

    return (result);
}

