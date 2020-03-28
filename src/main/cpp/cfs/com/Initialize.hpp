#ifndef CFS_COM_INITIALIZE_HPP
#define CFS_COM_INITIALIZE_HPP

#include <cstdint>
#include <atomic>

#include <cfs/com/LoggingService.hpp>

namespace cfs::com
{
    enum class Phase : std::uint8_t
    {
        INIT,
        APP_CLI_CONSOLE,
        GUI_MODE,
        USER_DEFINED,
        SYSTEM_HALT,  ///<! Application can be safely close with no nwk activity.
        REBOOT //*! which is used to restart the system.
    };

    enum class reset : std::uint8_t
    {
        COMPONENT_LEVEL,
        APPLICATION_LEVEL,
        OS_LEVEL
    };

    class Initialize
    {
	    LOG4CXX_DECLARE_STATIC_LOGGER
     public:

        explicit Initialize(int* argc, char** argv, bool flags = true);
        Initialize() = delete;
        Initialize(const Initialize&) = delete;
        Initialize(Initialize&&) = delete;
        Initialize& operator=(const Initialize&) = delete;
        Initialize& operator=(Initialize&&) = delete;
        virtual ~Initialize();

        void phases(const cfs::com::Phase & value);
        const cfs::com::Phase & phase() const noexcept;
        void phases();

     protected:

     private:
        static constexpr std::atomic<cfs::com::Phase> m_phase{cfs::com::Phase::INIT};

    };
}
#endif
