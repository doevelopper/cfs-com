
#ifndef CFS_COM_FEATURES_STEP_DEFINITIONS_RTI_BUILTINPUBLICATIONLISTENER_HPP
#define CFS_COM_FEATURES_STEP_DEFINITIONS_RTI_BUILTINPUBLICATIONLISTENER_HPP

namespace cfs::com::rti
{

    class BuiltinPublicationListener : public NoOpDataReaderListener<PublicationBuiltinTopicData>
    {

    public:

        void on_data_available(DataReader<PublicationBuiltinTopicData>& reader);

    protected:

    private:

        static log4cxx::LoggerPtr logger;

    };

}
#endif
