
#ifndef CFS_COM_ERROR_HPP
#define CFS_COM_ERROR_HPP

#include <type_traits>
#include <string>
#include <memory>
#include <system_error>

namespace cfs::com
{
    class Error
    {

    public:

        Error(void);
//        Error(std::string domain, std::uint32_t code, Dictionary userInfo);
        ~Error(void);
        std::uint32_t code( void ) const;
        std::string domain( void ) const;
//        cfs::com::Dictionary  userInfo( void ) const;
        std::string localizedDescription( void ) const;
        std::string localizedRecoveryOptions( void ) const;
        std::string localizedRecoverySuggestion( void ) const;
        std::string localizedFailureReason( void ) const;


    protected:
    private:
    };

}

#endif

