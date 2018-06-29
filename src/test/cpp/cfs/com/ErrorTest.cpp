
#include <cfs/com/ErrorTest.hpp>
#include <chrono>
#include <thread>

using namespace cfs::com::test;

ErrorTest::ErrorTest()
 : error()
{

}

ErrorTest::~ErrorTest()
{
}

void ErrorTest::SetUp ()
{
    error = new Error();
}

void ErrorTest::TearDown ()
{
    delete error;
}

TEST_F(ErrorTest, testTrue)
{
    std::this_thread::sleep_for(std::chrono::milliseconds(5000));
    EXPECT_TRUE(true);
}

