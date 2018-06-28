
#include <cfs/com/Error.hpp>

using namespace cfs::com;

Error::Error()
{

}

Error::~Error()
{

}

const char* Error::name() const noexcept 
{
  return "Error: ";
}

std::string Error::message(int ev) const 
{
    switch (static_cast<cfs::com::DdsErrs>(ev)) 
    {  
  case DdsErrs::None:
      return std::string("connection refuse");
  break;

        default:
            return std::string("[unrecognized error]");
  break;
    }
}

std::error_condition Error::default_error_condition(int ev) const noexcept
{
    switch (static_cast<cfs::com::DdsErrs>(ev))  
    {
        case DdsErrs::None:
            //return SubsystemError::SubsysInternal;
        default:
            return {};
    }
}

bool Error::equivalent(const std::error_code& code,
      int condition) const noexcept 
{
    switch (static_cast<Severity>(condition))
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

std::error_code Error::make_error_code(cfs::com::DdsErrs e)
{
    return {static_cast<int>(e), errorCategory};
}

std::system_error Error::make_syserr(int e, const char * msg)
{
    return std::system_error(std::error_code(e, std::system_category()), msg);
}

std::system_error Error::make_syserr(int e, const std::string & msg)
{ 
    return make_syserr(e, msg.c_str()); 
}

std::system_error Error::make_syserr(const std::string & msg)
{ 
    return make_syserr(errno, msg); 
}

std::system_error Error::make_syserr(const char * msg)
{ 
    return make_syserr(errno, msg); 
}


