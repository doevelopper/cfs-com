#ifndef CFS_COM_COMPONENT_HPP
#define CFS_COM_COMPONENT_HPP

#include <string>
#include <cfs/com/ShutdownSubject.hpp>
#include <cfs/com/LoggingService.hpp>
namespace cfs::com
{
    /*
     * @brief Component management class.
     *     Every software-component must provide exactly one instance of an IComponent.
     *     This class provides the base infrastructure for a software-component.
     *     This base-infrastructure is shared among all component's subentities such as
     *     the component's client- and server-ports as well as the user-tasks.
     *
     */

class Component : public ShutdownSubject
{
	LOG4CXX_DECLARE_STATIC_LOGGER
 public:
    Component() = delete;
    Component(const std::string & name);
    Component(const Component&) = delete;
    Component(Component&&) = delete;
    Component& operator=(const Component&) = delete;
    Component& operator=(Component&&) = delete;
    virtual ~Component();

    virtual int run(void) = 0;
    virtual void shutdown(void) = 0;
    virtual int blocking(const bool b) = 0;
    std::string name() const;
 protected:

 private:

    std::string m_name;
    bool m_isBlocking;
};
}

#endif
