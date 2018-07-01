
#include <cfs/com/Exception.hpp>

using namespace cfs::com;

Exception::Exception(void)
    : m_code(0)
    , m_reason("Unknown exception")
{

}

Exception::Exception(std::uint32_t code)
    : m_code(code)
    , m_reason("Unknown exception")
{

}

Exception::Exception(std::uint32_t code, std::string & reason)
    : m_code(code)
    , m_reason(reason)
{

}

Exception::~Exception() throw()
{

}

std::uint32_t
Exception::code() const
{
    return this->m_code;
}

void
Exception::code( std::uint32_t code )
{
    this->m_code = code;
}

const std::string &
Exception::reason() const
{
    return this->m_reason;
}

void
Exception::reason( const std::string & reason )
{
    this->m_reason = reason;
}

const char *
Exception::what() const throw()
{
    return this->m_reason.c_str();
}
