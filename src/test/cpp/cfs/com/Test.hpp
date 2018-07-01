
#ifndef CFS_COM_TEST_HPP
#define CFS_COM_TEST_HPP

#include <vector>
#include <gmock/gmock.h>

namespace cfs::com::test
{
    class Test
    {

    public:

        Test();
        Test(std::string & suite, unsigned int iteration = 1);
        Test(const Test & orig) = default;
        virtual
        ~Test();

        int run (int argc = 0, char * argv[] = NULL);
        static void showUsage(std::string name);

    protected:

    private:

        std::string m_testSuites;
        unsigned int m_numberOfTestIteration;
    };

}
#endif
