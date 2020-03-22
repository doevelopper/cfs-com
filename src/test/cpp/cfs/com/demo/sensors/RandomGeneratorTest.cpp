
#include <thread>
#include <chrono>

#include <cfs/com/demo/sensors/RandomGeneratorTest.hpp>

using namespace cfs::com::demo::sensors;
using namespace cfs::com::demo::sensors::test;

//log4cxx::LoggerPtr RandomGeneratorTest::logger = log4cxx::Logger::getLogger(std::string("cfs."));


RandomGeneratorTest::RandomGeneratorTest()
    : testee()
{
//    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

RandomGeneratorTest::~RandomGeneratorTest()
{
//    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
}

void RandomGeneratorTest::SetUp()
{
//    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    testee = new RandomGenerator();
}

void RandomGeneratorTest::TearDown()
{
//    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__ );
    delete testee;
}

TEST_F(RandomGeneratorTest, test_Simple)
{
//    LOG4CXX_TRACE(logger, __LOG4CXX_FUNC__);
//    std::this_thread::sleep_for(std::chrono::seconds(5));
    //testee->random<int>(0, 5, false);
    EXPECT_TRUE(testee->random(false));
    EXPECT_TRUE(testee->random(true));

    RandomGenerator generator;
    //testee->random<float>(0.0f, 5.0f, false);
}
