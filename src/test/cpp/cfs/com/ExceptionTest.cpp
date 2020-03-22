
#include <cfs/com/ExceptionTest.hpp>

using namespace cfs::com;
using namespace cfs::com::test;

//log4cxx::LoggerPtr ExceptionTest::logger = log4cxx::Logger::getLogger(std::string("cfs."));


ExceptionTest::ExceptionTest()
    : testee()
{
  //  LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

ExceptionTest::~ExceptionTest()
{
    //LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void ExceptionTest::SetUp()
{
    //LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    testee = new ExceptionT();
}

void ExceptionTest::TearDown()
{
   // LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    delete testee;
}

TEST_F(ExceptionTest, test_Simple_Version)
{
   // LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__);
}
