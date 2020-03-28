
#include <cfs/com/GTestEventListener.hpp>

using namespace cfs::com::test;

log4cxx::LoggerPtr GTestEventListener::logger = log4cxx::Logger::getLogger(std::string("cfs.com.test.GTestEventListener"));

GTestEventListener::GTestEventListener()
: m_currentTestCaseName("UKN"),
  m_currentTestName("UKN"),
  m_testCount(0),
  m_failedTestCount(0)

{
    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

GTestEventListener::~GTestEventListener()
{
    //LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void GTestEventListener::OnTestProgramStart(const testing::UnitTest& /*unit_test*/)
{
    LOG4CXX_TRACE(logger, "unit test started" );
}

void GTestEventListener::OnTestStart(const testing::TestInfo& test_info)
{
    ++m_testCount;
    m_currentTestCaseName = test_info.test_case_name();
    m_currentTestName =  test_info.name();

    LOG4CXX_TRACE(logger, "Test case: (" << m_currentTestCaseName << ") Test suite: (" << m_currentTestName << ")");
}

void GTestEventListener::OnTestPartResult( const testing::TestPartResult& test_part_result)
{
    if (test_part_result.failed())
    {
        LOG4CXX_TRACE(logger, "Test case failed : " << m_currentTestCaseName <<
                " Test suite: " << m_currentTestName <<
                " File: " << test_part_result.file_name() <<
                " Line: " << test_part_result.line_number() <<
                " Summary: " << test_part_result.summary());

    }
}

void GTestEventListener::OnTestEnd(const testing::TestInfo& test_info)
{
    LOG4CXX_TRACE(logger, "Test case finished: " << m_currentTestCaseName <<
            " Test suite: " << m_currentTestName <<
            " GOOD: " << !test_info.result()->Failed());

    if (test_info.result()->Failed())
        ++m_failedTestCount;
    m_currentTestCaseName.clear();
    m_currentTestName.clear();
}

void GTestEventListener::OnTestProgramEnd(const testing::UnitTest& /*unit_test*/)
{
    LOG4CXX_TRACE(logger, "Test case finished: Pass(" << m_testCount
            << "), Failed(" << m_failedTestCount << ")");
}

