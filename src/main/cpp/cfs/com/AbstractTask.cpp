
#include <cfs/com/AbstractTask.hpp>

using namespace cfs::com;

AbstractTask::AbstractTask(Component * component)
:	Shutdown(component)
{

}

AbstractTask::~AbstractTask()
{

}

void AbstractTask::on_shutdown()
{
    this->stop();
}
