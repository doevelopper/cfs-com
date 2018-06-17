
#ifndef CFS_COM_CORBA_VARINTERFACE_HPP
#define CFS_COM_CORBA_VARINTERFACE_HPP

namespace cfs::com::corba
{
    /*!
     * @brief  _var interface for local objects.
     */ 
    template <class T>
    class VarInterface
    {
    public:
        VarInterface();
	~VarInterface();
	VarInterface(const VarInterface<T> &)
	VarInterface<T>& operator = (T*t);
	VarInterface<T>& operator = (VarInterface<T> & t);
	T * operator ->();
	operator T*&();
        T * in();

    protected:

       T * get();
 
    private:
       T * m_pointee;
        
    }; 
}
#endif
