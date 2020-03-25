
#include <cfs/com/Task.hpp>

using namespace cfs::com;

Task::Task(Component *component)
:	AbstractTask(component)
,	m_cancelled(false)
{
}

Task::~Task()
{

}

bool Task::isCanceled()
{
	return (m_cancelled);
}

void Task::sleep(const Duration &duration)
{
	std::this_thread::sleep_for(duration);
}

int Task::start()
{
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
  	int result = 0;
	m_cancelled = true;

    if(m_asyncHandle.valid() && wait)
    {
        result = m_asyncHandle.get();
    }

    return (result);
}
