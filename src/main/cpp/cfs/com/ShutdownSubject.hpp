
#ifndef CFS_COM_SHUTDOWNSUBJECT_HPP
#define CFS_COM_SHUTDOWNSUBJECT_HPP

#include <list>
#include <mutex>
#include <cfs/com/Shutdown.hpp>

namespace cfs::com
{
    /*!
    * @brief This class implements the <b>Subject</b> (also called Model) part of the Observer design pattern for
    *       implementing a uniform shutdown procedure for all component's resources.
    *       An IComponent implements this interface to trigger all attached IShutdownObserver instances
    *       just before the IComponent finally shuts down.
    *
    *      Each communication pattern (clients and servers) and all user-defined Tasks attached to an IComponent
    *      should implement the counter-part IShutdownObserver interface (i.e. the on_shutdown() method) thus
    *      providing individual cleanup procedures/strategies.
    */

    class ShutdownSubject
    {
	    LOG4CXX_DECLARE_STATIC_LOGGER
    public:
        ShutdownSubject();
        ShutdownSubject(const ShutdownSubject&) = default;
        ShutdownSubject(ShutdownSubject&&) = default;
        ShutdownSubject& operator=(const ShutdownSubject&) = default;
        ShutdownSubject& operator=(ShutdownSubject&&) = default;
        virtual ~ShutdownSubject();

    protected:
        /*!
         * @brief Attach an Shutdown instance.
         *     This method should be called from within the constructor
         *     of an Shutdown instance. This is possible because
         *     the Shutdown is defined as a <i>friend class</i>
         *     of ShutdownSubject.
         */
        virtual void attach(Shutdown * t_observer);
        /*!
         * @brief Detach an Shutdown instance.
         *     This method should be called from within the destructor
         *     of an Shutdown instance. This is possible because
         *     the Shutdown is defined as a <i>friend class</i>
         *     of ShutdownSubject.
         */

        virtual void detach(Shutdown * t_observer);
        /*!
         * @brief Notifies all attached Shutdown instances about an upcoming shutdown.
         *     An instance of IComponent should call this method just before the component
         *     itself cleans-up its own internal resources. In this way, all the attached
         *     entities (such as client- and server-ports, as well as tasks) can clean-up
         *     their individual internal resources before the component invalidates its own
         *     internal resources. This effectively prevents nullpointer exceptions.
         */
        virtual void notify();

    private:
        /// allows calling protected attach() and detach() methods
        friend class Shutdown;
        std::mutex m_mutex;
        std::list<Shutdown *> m_observers;
    };
}

#endif

