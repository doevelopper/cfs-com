

#include <stdio.h>
#include <stdlib.h>

#include <cfs/com/corba/corba.hpp>

#if defined(CFS_OPENDDS_DDS)
    #include <cfs/com/opendds/OpenDDSTypeSupportImpl.h>
#elif defined(CFS_COREDX_DDS)
    #include <cfs/com/twinoaks/CoreDXTypeSupport.hh>
#elif defined(CFS_RTI_DDS)
    #include <cfs/com/rti/RTIConnextSupport.h>
#elif defined(CFS_OPENSPLICE_DDS)
    #include <cfs/com/prismtech/OpenSpliceDcps_Impl.h>
#elif defined(CFS_FASTRTPS_DDS)
    #include <fastrtps/rtps/rtps_all.h>
    #include <fastcdr/FastCdr.h>
#else
    # error No DDS AL should get a define to know the tye of DDS.
    # error No DDS vendor -define was provided. No DDS header files included.  Compilation will fail
    # error Please configure the makefile to define one for the following variables: RTI_CONNEXT_DDS, TWINOAKS_COREDX, or PRISMTECH_OPENSPLICE



#endif


