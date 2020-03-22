
#ifndef CFS_COM_EXCEPTION_HPP
#define CFS_COM_EXCEPTION_HPP

#include <stdexcept>
#include <string>

namespace cfs::com
{

    class Exception : public std::exception
    {

    public:

        Exception();
        Exception(const std::type_info & type);
        Exception(const std::string & message,
                const std::type_info & type = typeid(Exception));
        Exception(const std::string & message,
                       const std::exception & reason,
                       const std::type_info & type = typeid(Exception));

        Exception(const Exception& other) = delete;
        Exception(Exception&& other) = delete;
        Exception& operator=(Exception& rhs) = delete;
        Exception& operator=(Exception&& rhs) = delete;
        virtual ~Exception();

        Exception(std::uint32_t);
        Exception( std::uint32_t, std::string & );

    protected:

        virtual const char * what() const noexcept override;
        std::uint32_t code() const;
        void code( std::uint32_t );
        const std::string & reason() const;
        void reason( const std::string & );

    private:

        void swap( Exception & other) noexcept;
        static std::string prepareMessage(const std::type_info & type,
                                     const std::string & message);
        static std::string prepareMessage(const std::type_info & type,
                                     const std::string & message,
                                     const std::exception & cause);
        std::uint32_t m_code;
        std::string m_reason;
    };

}
#endif
