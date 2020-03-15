#include <time.h>
#include <cfs/com/demo/sensors/RandomGenerator.hpp>

using namespace cfs::com::demo::sensors;

RandomGenerator::RandomGenerator()
{

}

std::string RandomGenerator::timeSeed(std::string format)
{
	auto now = std::chrono::system_clock::now();
	auto now_c = std::chrono::system_clock::to_time_t(now);
	std::tm time;
	//localtime_s(&time, &now_c);

	std::stringstream ss;
	ss << std::put_time(&time, format.c_str());

	return ss.str();
}

template<typename T>
typename std::enable_if<std::is_integral<T>::value, T>::type
RandomGenerator::random(T min, T max, bool UseDateSeed)
{
    std::uniform_int_distribution<T> RandDist(min, max);

    if (UseDateSeed)
		return (RandDist(m_dateSeed));
	else
		return (RandDist(m_trueRand));
}

template<typename T>
typename std::enable_if<std::is_floating_point<T>::value, T>::type
RandomGenerator::random(T min, T max, bool UseDateSeed)
{
	std::uniform_real_distribution<T> RandDist(min, max);

	if (UseDateSeed)
		return (RandDist(m_dateSeed));
	else
		return (RandDist(m_trueRand));
}

bool RandomGenerator::random(bool UseDateSeed)
{
	std::bernoulli_distribution RandDist;
	if (UseDateSeed)
		return RandDist(m_dateSeed);
	else
		return RandDist(m_trueRand);
}

