#include <sstream>
#include <boost/core/demangle.hpp>
#include <cfs/com/Exception.hpp>

using namespace cfs::com;

Exception::Exception()
    : std::exception()
    , m_code(0)
    , m_reason("Unknown exception")
{

}

Exception::Exception(const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, ""))
{

}

Exception::Exception(const std::string & message,
                     const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, message))
{

}

Exception::Exception(std::uint32_t code)
    : std::exception()
    , m_code(code)
    , m_reason("Unknown exception")
{

}

Exception::Exception(const std::string & message,
                     const std::exception & cause,
                     const std::type_info & type)
    : std::exception()
    , m_reason(prepareMessage(type, message, cause))
{

}

Exception::Exception(std::uint32_t code, std::string & reason)
    : std::exception()
    , m_code(code)
    , m_reason(reason)
{

}

Exception::~Exception()
{

}

std::uint32_t Exception::code() const
{
    return this->m_code;
}

void Exception::code( std::uint32_t code )
{
    this->m_code = code;
}

const std::string & Exception::reason() const
{
    return this->m_reason;
}

void Exception::reason( const std::string & reason )
{
    this->m_reason = reason;
}

const char * Exception::what() const
{
    return (this->m_reason.c_str());
}

std::string  Exception::prepareMessage(const std::type_info & type,
                          const std::string & message)
{
    std::ostringstream stream;
    stream << "typeid(type)" << ": " << message;
    return stream.str();
}

std::string Exception::prepareMessage(const std::type_info & type,
                           const std::string & message,
                           const std::exception & cause)
{
    char const * name = typeid(cause).name();
    std::ostringstream stream;
    stream << boost::core::demangle( name ) << ": " << message << " caused by "
           << cause.what();
    return stream.str();
}

