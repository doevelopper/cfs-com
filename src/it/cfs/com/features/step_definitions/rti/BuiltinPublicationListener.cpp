
#include <cfs/com/features/step_definitions/rti/BuiltinPublicationListener.hpp>

log4cxx::LoggerPtr BuiltinPublicationListener::logger =
    log4cxx::Logger::getLogger(std::string("cfs.com.features.step_definitions.rti.builtinpublicationlistener"));

void
BuiltinPublicationListener::on_data_available(DataReader<PublicationBuiltinTopicData>& reader)
{
    LoanedSamples<PublicationBuiltinTopicData> samples = reader.take();

    using SampleIter = LoanedSamples<PublicationBuiltinTopicData>::iterator;

    for (SampleIter sample_it = samples.begin();
         sample_it != samples.end();
         sample_it++)
    {
        if (sample_it->info().valid())
        {
            const PublicationBuiltinTopicData& data = sample_it->data();
            const BuiltinTopicKey& partKey = data.participant_key();
            const BuiltinTopicKey& key = sample_it->data().key();

            LOG4CXX_DEBUG(logger, "Found topic " << data.topic_name());
            LOG4CXX_DEBUG(logger, "participant: " << partKey.value()[0]
                                                  << partKey.value()[1] << partKey.value()[2]);
            LOG4CXX_DEBUG(logger, "datawriter:  " << key.value()[0]
                                                  << key.value()[1]  << key.value()[2]);


            if (!data->type().is_set())
            {
                LOG4CXX_TRACE(logger,
                              "No type received, perhaps increase type_code_max_serialized_length?");
            }
            else
            {
                // Using the type propagated we print the data type
                // with print_idl()
                rti::core::xtypes::print_idl(data->type().get(), 2);
            }

        }
    }

}
