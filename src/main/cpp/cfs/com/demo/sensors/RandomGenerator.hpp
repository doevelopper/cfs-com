#ifndef CFS_COM_DEMO_SENSORS_RANDOMGENERATOR_HPP
#define CFS_COM_DEMO_SENSORS_RANDOMGENERATOR_HPP

#include <random>
#include <chrono>
#include <string>
#include <algorithm>
#include <sstream>
#include <locale>
#include <iomanip>

namespace cfs::com::demo::sensors
{
    template <class T>
    using isFloat = std::enable_if_t<std::is_floating_point_v<T>>;
    class RandomGenerator
    {
        class Rand
        {
            public:
                explicit Rand(int low, int high): m_dist{low, high} {}
                explicit Rand(double low, double high): m_rdist{low, high} {}
                int operator()() { return m_dist(m_re); }
            protected:
            private:
                std::random_device m_rd;
                std::default_random_engine m_re{m_rd()};
                std::uniform_int_distribution<> m_dist;
                std::uniform_real_distribution<> m_rdist;
        };

    public:
        RandomGenerator();
        RandomGenerator(const RandomGenerator&) = default;
        RandomGenerator(RandomGenerator&&) = default;
        RandomGenerator& operator=(const RandomGenerator&) = default;
        RandomGenerator& operator=(RandomGenerator&&) = default;
        virtual ~RandomGenerator();

        std::string timeSeed(std::string Format = "%Y-%m-%d");
        template<typename T>
        typename std::enable_if<std::is_integral<T>::value, T>::type
        random(T min, T max, bool UseDateSeed = true);

        template<typename T>
        typename std::enable_if<std::is_floating_point<T>::value, T>::type
        random(T min, T max, bool UseDateSeed = true);

        bool random(bool UseDateSeed = true);

        void trueRand(const std::mt19937 & data);
	    const std::mt19937 & trueRand() const;
        void dateSeed(const std::mt19937 & data);
	    const std::mt19937 & dateSeed() const;

    protected:

    private:

        std::mt19937 m_trueRand;
        std::mt19937 m_dateSeed;

    };
}

#endif
