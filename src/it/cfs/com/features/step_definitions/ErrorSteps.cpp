
#include <cfs/com/features/step_definitions/ErrorSteps.hpp>
namespace cfs::com::it::e
{
    GIVEN("^I have raised error code (\\d+)")
    {
        REGEX_PARAM(std::uint32_t, n);
        cucumber::ScenarioScope<ErrorContext> errctx;

        //errctx->message = errctx->error.name().c_str();
        //errctx->error.push(n);
    }

    WHEN("^I have set (.*)$")
    {
        REGEX_PARAM(std::string, word);
        cucumber::ScenarioScope<ErrorContext> context;

        //context->encoded = context->soundex.encode(word);
    }
}
