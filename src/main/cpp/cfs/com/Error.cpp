
#include <cfs/com/Error.hpp>

using namespace cfs::com;

log4cxx::LoggerPtr Error::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Error"));

Error::Error()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Error::~Error()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

const char* Error::name() const noexcept
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    return "Error: ";
}
/*
std::string Error::message(int ev) const
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    switch (static_cast<cfs::com::ErrorCode>(ev))
    {
        case ErrorCode::None:

            return std::string("connection refuse");

            break;

        default:

            return std::string("[unrecognized error]");

            break;
    }
}

std::error_condition Error::default_error_condition(int ev) const noexcept
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    switch (static_cast<cfs::com::ErrorCode>(ev))
    {
        case ErrorCode::None:

        //return SubsystemError::SubsysInternal;
        default:
            return {};
    }
}

bool Error::equivalent(const std::error_code& code, int condition) const noexcept
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    switch (static_cast<cfs::com::ErrorCode>(condition))
    {
//       case Severity::Heisenbug:
//	    return ((code == SubsystemError::SubsysInternal)
//		    || (code == SubsystemError::SubsysInternal));
//       case Severity::Hindenbug
//       case Severity::Schroedinbug
//       case Severity::Bohrbug
//       case Severity::Mandelbug
        default:
            return (false);
    }
}

std::error_code Error::make_error_code(cfs::com::ErrorCode e)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    return {static_cast<int>(e), errorCategory};
    //return (std::error_code(static_cast<int>(e), Error::get()));
}

std::system_error Error::make_syserr(int e, const char * msg)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    return std::system_error(std::error_code(e, std::system_category()), msg);
}

std::system_error Error::make_syserr(int e, const std::string & msg)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    return make_syserr(e, msg.c_str());
}

std::system_error Error::make_syserr(const std::string & msg)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    return make_syserr(errno, msg);
}

std::system_error Error::make_syserr(const char * msg)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );

    return make_syserr(errno, msg);
}

*/