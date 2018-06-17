
#include <cfs/com/Error.hpp>
///
/// Convienience functions for making system_error exception
///
inline std::system_error make_syserr(int e, const char * msg)
{
    return std::system_error(std::error_code(e, std::system_category()), msg);
}

inline std::system_error make_syserr(int e, const std::string & msg)
{ 
    return make_syserr(e, msg.c_str()); 
}

inline std::system_error make_syserr(const std::string & msg)
{ 
    return make_syserr(errno, msg); 
}

inline std::system_error make_syserr(const char * msg)
{ 
    return make_syserr(errno, msg); 
}
