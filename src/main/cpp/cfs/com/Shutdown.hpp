#ifndef CFS_COM_SHUTDOWN_HPP
#define CFS_COM_SHUTDOWN_HPP

#include <list>
#include <mutex>


namespace cfs::com
{

    class ShutdownSubject;

    /*!
     * @brief This class implements the <b>Observer</b> part of the Observer design pattern for
     *        implementing a uniform shutdown procedure for all component's resources.
     *      An IComponent implements the counter-part IShutdownSubject interface that will trigger all
     *      attached Shutdown instances just before the IComponent finally shuts down.
     *      Each communication pattern (clients and servers) attached to an IComponent should implement
     *      IShutdownObserver interface (i.e. the on_shutdown() method) thus providing individual
     *      cleanup strategies.
     */

    class Shutdown
    {
	    //LOG4CXX_DECLARE_STATIC_LOGGER
    public:
        /*!
         * @brief The default constructor.
         *     This constructor will call <b>subject->attach(this)</b> to start observing the given subject.
         * @param subject The subject (also called model) that this Observer is going to observe
         */
        Shutdown(ShutdownSubject *subject = nullptr);
        Shutdown(const Shutdown&) = default;
        Shutdown(Shutdown&&) = default;
        Shutdown& operator=(const Shutdown&) = default;
        Shutdown& operator=(Shutdown&&) = default;

        /*
         * @brief The default constructor.
         *     This destructor will call <b>subject->detach(this)</b> to stop observing the given subject.
         */
        virtual ~Shutdown();

        /*!
         * @brief This is the main update method that will be automatically called from the given subject
         *     each time the subject undergoes a notable change.
         *     This method should be implemented in derived classes to provide an individual shutdown.
         */
        virtual void on_shutdown() = 0;

    protected:
        /*!
         * @bref Call this method from within the constructor of derived classes
         *     The Shutdown interface can be derived pure virtual which means that
         *     in these cases the default empty constructor will be called.
         *     For the pure virtual derivation, the constructor of the derived class
         *     should call this method manually to ensure proper registration of the
         *     Shutdown.
         * @param subject the subject (i.e. model) of the Observer design pattern
         */
        void add(ShutdownSubject * t_subject);
        /*!
         * @brief This method is called within the destructor
         *      This method is called from within the destructor of this class if the
         *      internal subject pointer has been set-up before using the attach_self_to() method.
         * @param subject the subject (i.e. model) of the Observer design pattern
         */

        void remove(ShutdownSubject * t_subject);

    private:

        ShutdownSubject * m_subject;

    };
}

#endif

