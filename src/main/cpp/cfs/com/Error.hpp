
#ifndef CFS_COM_ERROR_HPP
#define CFS_COM_ERROR_HPP

#include <type_traits>
#include <string>
#include <memory>
#include <system_error>

namespace cfs::com
{

    enum class DdsErrs 
    {
        None, /* ... */ 
    };

    enum class SubsystemError
    {
  SubsysInternal,
    };

    enum class Severity
    {
        Heisenbug,    //!< Bug that seems to disappear or alter its behavior when one attempts to study it.
        Hindenbug,    //!< Bug with catastrophic behavior.
        Schroedinbug, //!< Bug that manifests itself in running software.
        Bohrbug,      //!< Bug that do not change its behavior and are relatively easily detected.
        Mandelbug     //!< Bug whose causes are so complex.
    };

    class Error  : std::error_category
    {

    public:

        Error(void);
//        Error(std::string domain, std::uint32_t code, Dictionary userInfo);
        virtual ~Error(void);
        std::uint32_t code( void ) const;
        std::string domain( void ) const;
//        cfs::com::Dictionary  userInfo( void ) const;
        std::string localizedDescription( void ) const;
        std::string localizedRecoveryOptions( void ) const;
        std::string localizedRecoverySuggestion( void ) const;
        std::string localizedFailureReason( void ) const;
//        virtual Error * clone() const = 0;
    protected:
        const char* name() const noexcept override;
        std::string message(int ev) const override;
        std::error_condition default_error_condition(int ev) const noexcept override;
        bool equivalent(const std::error_code& code, int condition) const noexcept override;
    private:

        ///
        /// Convienience functions for making system_error exception
        ///

        std::error_code make_error_code(cfs::com::DdsErrs);
        std::error_condition make_error_condition(cfs::com::SubsystemError e);
        std::error_condition make_error_condition(cfs::com::Severity e);
        std::system_error make_syserr(int e, const char * msg);
        std::system_error make_syserr(int e, const std::string & msg);
        std::system_error make_syserr(const std::string & msg);
        std::system_error make_syserr(const char * msg);
    };


    const Error errorCategory {};
}


namespace std 
{
    template<> 
    struct is_error_condition_enum<cfs::com::DdsErrs> : std::true_type
    {};
    template <>
    struct is_error_condition_enum<cfs::com::SubsystemError> : std::true_type 
    {};
    template <>
    struct is_error_condition_enum<cfs::com::Severity> : std::true_type
    {};
}

#endif

