
#ifndef CFS_COM_ERROR_HPP
#define CFS_COM_ERROR_HPP
#include <iostream>
#include <sstream>
#include <type_traits>
#include <string>
#include <memory>
#include <system_error>

/*

   try
    {
        throw std::system_error(EFAULT, std::generic_category());
    }
    catch (std::system_error& error)
    {
        std::cout << "Error: " << error.code() << " - " << error.what() << '\n';
        assert(error.code() == std::errc::bad_address);
    }
*/

namespace cfs::com
{

    enum class ErrorCode : std::uint8_t
    {
        None, /* ... */
        ACCESS_DENIED, /*permission denied*/
        ALREADY_EXISTS,
        BAD_UNIT, /*no such device*/
        BUSY,  /*device or resource busy*/
        CANTOPEN, /*io error*/
        CANTREAD,
        DEV_NOT_EXIST, /*no such device*/
        DEVICE_IN_USE, /*device or resource busy*/
        DISK_FULL, /*no space on device*/
        FILE_NOT_FOUND, /*no such file or directory*/
        INVALID_ACCESS,
        LOCK_VIOLATION, /*no lock available*/
        LOCKED, /*no lock available*/
        NOT_ENOUGH_MEMORY, /*not enough memory*/
        NOT_READY, /*resource unavailable try againresource unavailable try again*/
        OPERATION_ABORTED, /*operation canceled*/
        CRYPTO_EXCEPTION_INSUFFICIENT_PROTECTION,
        CRYPTO_EXCEPTION_KEY_EXPIRED,
        CRYPTO_EXCEPTION_NO_KEY_FOUND,
        CRYPTO_EXCEPTION_REASON_UNKNOWN,
        CRYPTO_EXCEPTION_RESOURCE_BUSY,
        CRYPTO_EXCEPTION_SESSION_NOT_OPENED,
        CRYPTO_EXCEPTION_UNSUPPORTED_OPERATION,
        DEVICE_NOT_PROVISIONED,
        DRM_KEYS_EXPIRED,
        DRM_NOT_SUPPORTED,
        DRM_SECURITY_LEVEL_INSUFFICIENT,
        DRM_SERVER_DENIED_ERROR,
        DRM_STATE_RESET_ERROR,
        ERROR_GETTING_MANIFEST,
        ERROR_GETTING_MANIFEST_INVALID_REQUEST,
        ERROR_GETTING_MANIFEST_NETWORK_IO_ERROR,
        ERROR_GETTING_MANIFEST_NETWORK_UNREACHABLE,
        ERROR_GETTING_MANIFEST_SERVER_ERROR,
        ERROR_GETTING_META,
        ERROR_GETTING_META_INVALID_REQUEST,
        ERROR_GETTING_META_NETWORK_IO_ERROR,
        ERROR_GETTING_META_NETWORK_UNREACHABLE,
        ERROR_GETTING_META_SERVER_ERROR,
        FAILED_TO_CREATE_KEY_REQUEST,
        FAILED_TO_CREATE_KEY_REQUEST_ILLEGAL_STATE_ERROR,
        FAILED_TO_CREATE_KEY_REQUEST_NOT_PROVISIONED,
        FAILED_TO_CREATE_PROVISION_REQUEST,
        FAILED_TO_CREATE_PROVISION_REQUEST_ILLEGAL_STATE_ERROR,
        FAILED_TO_INITIATE_CDM,
        FAILED_TO_INITIATE_CDM_ILLEGAL_STATE_ERROR,
        FAILED_TO_OPEN_DRM_SESSION,
        FAILED_TO_OPEN_DRM_SESSION_ILLEGAL_STATE_ERROR,
        FAILED_TO_OPEN_DRM_SESSION_RESOURCE_BUSY,
        FAILED_TO_RESTORE_KEYS,
        FAILED_TO_RESTORE_KEYS_ILLEGAL_STATE_ERROR,
        ILLEGAL_DRM_STATE_ERROR,
        ILLEGAL_MEDIA_DRM_STATE_ERROR,
        INTERNAL_ERROR,
        INVALID_INIT_PARAMS,
        INVALID_OTP_OR_SIGNATURE,
        INVALID_PLAYBACK_INFO,
        KEY_REQUEST_FAILED,
        KEY_REQUEST_FAILED_INVALID_REQUEST,
        KEY_REQUEST_FAILED_NETWORK_IO_ERROR,
        KEY_REQUEST_FAILED_SERVER_ERROR,
        KEY_RESPONSE_REJECTED,
        KEY_RESPONSE_REJECTED_ILLEGAL_STATE_ERROR,
        KEY_RESPONSE_REJECTED_SERVER_DENIED,
        MEDIA_CRYPTO_EXCEPTION,
        META_DATA_BAD_FORMAT,
        NETWORK_ERROR,
        NETWORK_ERROR_INVALID_REQUEST,
        NETWORK_ERROR_SERVER_ERROR,
        NETWORK_UNREACHABLE,
        NO_SUPPORTED_MEDIA_DELIVERY_FORMAT,
        NULL_INIT_PARAMS,
        NULL_OTP_OR_SIGNATURE,
        NULL_PLAYBACK_INFO,
        PARSER_ERROR,
        PLAYBACK_INFO_BAD_FORMAT,
        PLAYER_HOST_NOT_READY,
        PROVISION_REQUEST_FAILED,
        PROVISION_REQUEST_FAILED_INVALID_REQUEST,
        PROVISION_REQUEST_FAILED_SERVER_ERROR,
        PROVISION_RESPONSE_REJECTED,
        PROVISION_RESPONSE_REJECTED_ILLEGAL_STATE_ERROR,
        PROVISIONING_DENIED,
        RENDERER_ERROR,
        SDK_INCOMPATIBLE_UPGRADE_REQUIRED,
        SUCCESS,
        SYSTEM_INTERNAL_ERROR,
        UNKNOWN_DRM_ERROR,
    };

    class Error : std::error_category
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
        // Throws the system error under a given error code.
        template <typename... ArgsT>
        void throwError(const char* msg, const std::size_t line, cfs::com::ErrorCode c, ArgsT&&... args)
        {
            std::ostringstream oss;
            oss << "[" << msg << ":" << line << "] ";
            (oss << ... << args);
            throw std::system_error(c, oss.str());
        }

    protected:

        const char* name() const noexcept override final;
        std::string message(int ev) const override final;
        std::error_condition default_error_condition(int ev) const noexcept override;
        bool equivalent(const std::error_code& code, int condition) const noexcept override;
        /*!
         * @brief Acquires the singleton instance of the error category
         */
        static const std::error_category& get();

    private:

///
/// Convienience functions for making system_error exception
///

        std::error_code make_error_code(cfs::com::ErrorCode);
        //std::error_condition make_error_condition(cfs::com::SubsystemError e);
        //std::error_condition make_error_condition(cfs::com::Severity e);
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
    struct is_error_condition_enum<cfs::com::ErrorCode> : std::true_type {};
/*
    template <>
    struct is_error_condition_enum<cfs::com::SubsystemError> : std::true_type
    {};
    template <>
    struct is_error_condition_enum<cfs::com::Severity> : std::true_type
    {};
*/
}

#endif
