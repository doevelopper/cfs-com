
#ifndef CFS_COM_GTESTEVENTLISTENER_HPP
#define CFS_COM_GTESTEVENTLISTENER_HPP
#include <iostream>
#include <string>

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include <cfs/com/LoggingService.hpp>

namespace cfs::com::test
{
    class GTestEventListener final : public testing::EmptyTestEventListener
    {
        LOG4CXX_DECLARE_STATIC_LOGGER
    public:
        GTestEventListener();
        ~GTestEventListener();
        void OnTestProgramStart(const testing::UnitTest& /*unit_test*/) override;
        void OnTestStart(const testing::TestInfo& test_info) override;
        void OnTestPartResult(const testing::TestPartResult& test_part_result) override;
        void OnTestEnd(const testing::TestInfo& test_info) override;
        void OnTestProgramEnd(const testing::UnitTest& /*unit_test*/) override;

    protected:

    private:
        std::string m_currentTestCaseName;
        std::string m_currentTestName;
        int m_testCount;
        int m_failedTestCount;
    };

}

#endif
