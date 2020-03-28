
#ifndef CFS_COM_ABSTRACTTASK_HPP
#define CFS_COM_ABSTRACTTASK_HPP

#include <chrono>
#include <cfs/com/Component.hpp>
//#include <cfs/com/ShutdownSubject.hpp>
#include <cfs/com/Shutdown.hpp>
#include <cfs/com/LoggingService.hpp>
namespace cfs::com
{
    using Clock = std::chrono::steady_clock;
    using Duration = Clock::duration;
    using TimePoint = Clock::time_point;

class AbstractTask : public Shutdown
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    AbstractTask(Component * component = nullptr);
    AbstractTask() = delete;
    AbstractTask(const AbstractTask&) = default;
    AbstractTask(AbstractTask&&) = default;
    AbstractTask& operator=(const AbstractTask&) = default;
    AbstractTask& operator=(AbstractTask&&) = default;
    virtual ~AbstractTask();

    virtual int start() = 0;
    virtual int stop(const bool untilStop=true) = 0;

 protected:
    virtual void on_shutdown();
    virtual bool isCanceled() = 0;
    virtual void sleep(const Duration &duration) = 0;
    virtual int execution() = 0;
 private:

};
}

#endif
