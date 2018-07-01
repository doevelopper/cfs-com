
#include <cfs/com/features/step_definitions/DdsSteps.hpp>

using cucumber::ScenarioScope;

namespace cfs::com::it::dds
{
    GIVEN("^I execute this dummy$")
    {
        EXPECT_TRUE(true);
    }

    GIVEN("^I press fab$")
    {
        EXPECT_TRUE(true);
    }

    THEN("^I should see some output$")
    {
        EXPECT_TRUE(true);
    }

    THEN("^Success$")
    {
        EXPECT_TRUE(true);
    }
}
/*
   BEFORE_ALL()
   {
    std::cout << "-------------------- (Before all scenarios)" << std::endl;
   }

   AFTER_ALL()
   {
    std::cout << "-------------------- (After all scenarios)" << std::endl;
   }

   BEFORE()
   {
    std::cout << "-------------------- (Before any scenario)" << std::endl;
   }

   AFTER()
   {
    std::cout << "-------------------- (After any scenarios)" << std::endl;
   }



   BEFORE("@foo,@bar","@baz")
   {
    std::cout << "Before scenario (\"@foo,@baz\",\"@bar\")" << std::endl;
   }

   AROUND_STEP("@baz")
   {
    std::cout << "Around step (\"@baz\") ...before" << std::endl;
    // step->call();
    std::cout << "Around step (\"@baz\") ..after" << std::endl;
   }

   AFTER_STEP("@bar")
   {
    std::cout << "After step (\"@bar\")" << std::endl;
   }

   AFTER("@foo")
   {
    std::cout << "After scenario (\"@foo\")" << std::endl;
   }

   AFTER("@gherkin")
   {
    std::cout << "After scenario (\"@gherkin\")" << std::endl;
   }


   GIVEN("^I have crated a logger and set (\\d+)ms as file watch period$")
   {
    REGEX_PARAM(double, n);
    //ScenarioScope<LoggingContext> context;
    //context->context.;
    EXPECT_TRUE(true);
   }

   GIVEN("^I execute this dummy$")
   {
    EXPECT_TRUE(true);
   }

   GIVEN("^I press fab$")
   {
    EXPECT_TRUE(true);
   }

   THEN("^I should see some output$")
   {
    EXPECT_TRUE(true);
   }

   THEN("^Success$")
   {
    EXPECT_TRUE(true);
   }

   //*/
