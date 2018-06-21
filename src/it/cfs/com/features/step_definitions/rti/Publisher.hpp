/*******************************************************************************
 (c) 2005-2015 Copyright, Real-Time Innovations, Inc.  All rights reserved.
 RTI grants Licensee a license to use, modify, compile, and create derivative
 works of the Software.  Licensee has the right to distribute object form only
 for use with RTI products.  The Software is provided "as is", with no warranty
 of any type, including any warranty for fitness for any purpose. RTI is under
 no obligation to maintain or support the Software.  RTI shall not be liable for
 any incidental or consequential damages arising out of the use or inability to
 use the software.
 ******************************************************************************/

#ifndef CFS_COM_FEATURES_STEP_DEFINITIONS_RTI_PUBLISHER_HPP
#define CFS_COM_FEATURES_STEP_DEFINITIONS_RTI_PUBLISHER_HPP

#include <cstdlib>
#include <iostream>

#include <dds/dds.hpp>
#include <cfs/com/features/step_definitions/Msg.hpp>

namespace cfs::com::rti
{
    class Publisher
    {

    public:

        Publisher();
        ~Publisher();
        Publisher(int domainId, int sampleCount);

    protected:

    private:

    };

}
#endif
