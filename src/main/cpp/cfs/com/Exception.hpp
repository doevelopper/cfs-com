
#ifndef CFS_COM_EXCEPTION_HPP
#define CFS_COM_EXCEPTION_HPP

#include <stdexcept>
#include <string>

namespace cfs::com
{
    class Exception : public std::exception
    {

    public:
        Exception(void);
	Exception(const Exception& other);
	Exception(Exception&& other);
	Exception& operator=(Exception& rhs);
	Exception& operator=(Exception&& rhs);
	/*!
	 * @cond 
	 */
	virtual ~Exception(void) throw();
	/*!
	 * @endcond
	 */

	Exception(std::uint32_t);
	Exception( std::uint32_t, std::string & );
    protected:
        virtual const char * what() const throw();
	std::uint32_t code() const;
	void code( std::uint32_t );
	const std::string & reason() const;
	void reason( const std::string & );

    private:

        void swap( Exception & other) noexcept;

	std::uint32_t m_code;
	std::string m_reason;
    };
}
#endif

