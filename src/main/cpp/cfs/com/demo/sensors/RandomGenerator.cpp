#include <ctime>
#include <cstdint>
#include <cfs/com/demo/sensors/RandomGenerator.hpp>

using namespace cfs::com::demo::sensors;

RandomGenerator::RandomGenerator()
{
    std::string dateseed = timeSeed();
    std::seed_seq dateseedseq(dateseed.begin(), dateseed.end());
    m_dateSeed = std::mt19937(dateseedseq);
    uint_least32_t trueseed[std::mt19937::state_size];
    std::random_device randDevice;
    std::generate_n(trueseed, std::mt19937::state_size, std::ref(randDevice));
    std::seed_seq trueseedseq(std::begin(trueseed), std::end(trueseed));
    m_trueRand = std::mt19937(trueseedseq);

}

RandomGenerator::~RandomGenerator()
{

}

std::string RandomGenerator::timeSeed(std::string format)
{
	auto now = std::chrono::system_clock::now();
	auto now_c = std::chrono::system_clock::to_time_t(now);
	std::tm time;
//	localtime_s(&time, &now_c);
	localtime(&now_c);

	std::stringstream ss;
	//ss << std::put_time(std::localtime(&time), format.c_str());
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

void RandomGenerator::trueRand(const std::mt19937 & data)
{
    m_trueRand = data;
}

const std::mt19937 & RandomGenerator::trueRand() const
{
    return(m_trueRand);
}

void RandomGenerator::dateSeed(const std::mt19937 & data)
{
    m_dateSeed = data;
}

const std::mt19937 & RandomGenerator::dateSeed() const
{
    return(m_dateSeed);
}

