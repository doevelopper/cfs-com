#include <sstream>
#include <boost/core/demangle.hpp>
#include <cfs/com/Exception.hpp>

using namespace cfs::com;

log4cxx::LoggerPtr Exception::logger = log4cxx::Logger::getLogger(std::string("cfs.com.Exception"));

Exception::Exception()
    : std::exception()
    , m_code(0)
    , m_reason("Unknown exception")
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::Exception(const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, ""))
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::Exception(const std::string & message,
                     const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, message))
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::Exception(std::uint32_t code)
    : std::exception()
    , m_code(code)
    , m_reason("Unknown exception")
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::Exception(const std::string & message,
                     const std::exception & cause,
                     const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, message, cause))
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::Exception(std::uint32_t code, std::string & reason)
    : std::exception()
    , m_code(code)
    , m_reason(reason)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

Exception::~Exception()
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

std::uint32_t Exception::code() const
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    return this->m_code;
}

void Exception::code( std::uint32_t code )
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    this->m_code = code;
}

const std::string & Exception::reason() const
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    return this->m_reason;
}

void Exception::reason( const std::string & reason )
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    this->m_reason = reason;
}

const char * Exception::what() const
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    return (this->m_reason.c_str());
}

std::string  Exception::prepareMessage(const std::type_info & type,
                          const std::string & message)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    std::ostringstream stream;
    stream << "typeid(type)" << ": " << message;
    return stream.str();
}

std::string Exception::prepareMessage(const std::type_info & type,
                           const std::string & message,
                           const std::exception & cause)
{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    char const * name = typeid(cause).name();
    std::ostringstream stream;
    stream << boost::core::demangle( name ) << ": " << message << " caused by "
           << cause.what();
    return stream.str();
}

