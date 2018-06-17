
#ifndef CFS_COM_CORBA_VARSTRINGINTERFACE_HPP
#define CFS_COM_CORBA_VARSTRINGINTERFACE_HPP

namespace cfs::com::corba
{
    class VarStringInterface
    {
    public:

        VarStringInterface ();
        VarStringInterface (std::string & p);
        VarStringInterface (const VarStringInterface & s);
        VarStringInterface & operator = (std::string & p);
        virtual ~VarStringInterface ();
        VarStringInterface & operator = (const VarStringInterface & s);

    	char* stringallocate(ULong len);
		char* stringDup(const char* s);
		void stringFree(char* s);
        operator char * ();
        char & operator [] (ULong index);
        char operator [] (ULong index) const;

    protected:
	private:
        std::string & m_ptr;
        
    };
}
#endif

