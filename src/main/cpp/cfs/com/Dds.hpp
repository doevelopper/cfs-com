

#if defined(CFS_OPENDDS_DDS)
    #include <cfs/com/dds/IDLNAMETypeSupportImpl.h>
#elif defined(CFS_COREDX_DDS)
    #include <cfs/com/dds/IDLNAMETypeSupport.hh>
#elif defined(CFS_RTI_DDS)
    #include <cfs/com/dds/IDLNAMESupport.h>
#elif defined(CFS_OPENSPLICE_DDS)
    #include <cfs/com/dds/IDLNAMEDcps_Impl.h>
#else
    #error "No DDS AL should get a define to know the tye of DDS."
#endif


