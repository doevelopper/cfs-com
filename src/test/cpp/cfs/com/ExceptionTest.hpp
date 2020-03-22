#ifndef CFS_COM_EXCEPTIONTEST_HPP
#ifndef CFS_COM_EXCEPTIONTEST_HPP

#include <gmock/gmock.h>
#include <cfs/com/Exception.hpp>

namespace cfs::com::test
{
    class ExceptionTest : public ::testing::Test
    {
		LOG4CXX_DECLARE_STATIC_TEST_LOGGER
        public:

            ExceptionTest();
            ExceptionTest(const ExceptionTest&) = default;
            ExceptionTest(ExceptionTest&&) = default;
            ExceptionTest& operator=(const ExceptionTest&) = default;
            ExceptionTest& operator=(ExceptionTest&&) = default;
            virtual ~ExceptionTest();

            void SetUp() override;
            void TearDown() override;

        protected:

            cfs::com::Exception * testee;

        private:
    };
}
#endif
