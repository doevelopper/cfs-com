
#include <cfs/com/ErrorTest.hpp>

using namespace cfs::com::test;

ErrorTest::ErrorTest()
{

}

ErrorTest::~ErrorTest()
{

}

void ErrorTest::SetUp ()
{

}

void ErrorTest::TearDown ()
{

}

TEST_F(ErrorTest, testTrue)
{
    EXPECT_TRUE(true);
}

