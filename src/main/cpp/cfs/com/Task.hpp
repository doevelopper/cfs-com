#ifndef CFS_COM_TASK_HPP
#define CFS_COM_TASK_HPP
#include <atomic>
#include <future>
#include <cfs/com/AbstractTask.hpp>

namespace cfs::com
{
    class Task : virtual public AbstractTask
    {
	    LOG4CXX_DECLARE_STATIC_LOGGER
    public:
        Task() = delete;
        Task(const Task&) = default;
        Task(Task&&) = default;
        Task& operator=(const Task&) = default;
        Task& operator=(Task&&) = default;
        virtual ~Task();

        Task(cfs::com::Component *component = nullptr);

    protected:
        virtual bool isCanceled() override;
        virtual void sleep(const cfs::com::Duration & duration) override;
        virtual int start() override;
        virtual int stop(const bool tillTtopped=true) override;

    private:

	    std::atomic<bool> m_cancelled;
    	std::future<int> m_asyncHandle;

    };
}
#endif
