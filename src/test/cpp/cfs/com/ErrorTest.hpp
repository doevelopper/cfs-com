
#ifndef CFS_COM_ERRORTEST_HPP
#define CFS_COM_ERRORTEST_HPP


#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include <cfs/com/Error.hpp>

namespace cfs::com::test
{
    class ErrorTest : public ::testing::Test
    {

    public:

        ErrorTest();
	~ErrorTest();

    protected:

        void SetUp() override;
	void TearDown() override;

    private:


    };

}

#endif

