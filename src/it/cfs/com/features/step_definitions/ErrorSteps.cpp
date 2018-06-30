
#include <cfs/com/features/step_definitions/ErrorSteps.hpp>
namespace cfs::com::it::e
{
    GIVEN("^I have raised error code (\\d+)") 
    {
        REGEX_PARAM(int, n);
        cucumber::ScenarioScope<ErrorContext> errctx;

        //errctx->error.push(n);
    }
}

