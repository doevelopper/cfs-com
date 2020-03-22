
#ifndef CFS_COM_DEMO_SENSORS_RANDOMGENERATORTEST_HPP
#define CFS_COM_DEMO_SENSORS_RANDOMGENERATORTEST_HPP

#include <gmock/gmock.h>
#include <cfs/com/demo/sensors/RandomGenerator.hpp>

namespace cfs::com::demo::sensors::test
{
    class RandomGeneratorTest : public ::testing::Test
    {
		//LOG4CXX_DECLARE_STATIC_TEST_LOGGER
        public:

            RandomGeneratorTest();
            RandomGeneratorTest(const RandomGeneratorTest&) = default;
            RandomGeneratorTest(RandomGeneratorTest&&) = default;
            RandomGeneratorTest& operator=(const RandomGeneratorTest&) = default;
            RandomGeneratorTest& operator=(RandomGeneratorTest&&) = default;
            virtual ~RandomGeneratorTest();

            void SetUp() override;
            void TearDown() override;

        protected:

            cfs::com::demo::sensors::RandomGenerator *  testee;

        private:
    };
}

#endif

