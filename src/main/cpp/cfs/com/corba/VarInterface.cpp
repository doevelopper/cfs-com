
#include <cfs/com/corba/VarInterface.hpp>

using namespace cfs::com::corba;

template <class T>
VarInterface<T>::VarInterface()
    : m_ptr (nullptr)
{
}

template <class T>
VarInterface<T>::VarInterface(T * p)
    : m_ptr (p)
{
}

template <class T>
VarInterface<T>::VarInterface(const VarInterface<T>& t)
    : m_ptr(t.m_ptr)
{
    if (t.m_ptr) 
    {
        t.m_ptr->_add_ref ();
    }
}

template <class T>
VarInterface<T>::~VarInterface()
{
    if(m_ptr) 
    {
        m_ptr->_remove_ref();
    }
}

template <class T> 
VarInterface<T> & VarInterface<T>::operator=(T* t)
{
    if(m_ptr) 
    {
        m_ptr->_remove_ref();
    }
    m_ptr = t;
    return (*this);
}

template <class T> 
VarInterface<T> & VarInterface<T>::operator=(VarInterface<T>& t)
{
    if(m_ptr) 
    {
        m_ptr->_remove_ref();
    }

    m_ptr = t.in();

    if (m_ptr) 
    {
        m_ptr->_add_ref ();
    }

    return (*this);
}

template <class T> 
T * VarInterface<T>::operator->()
{
    return (m_pointee);
}

template <class T>
VarInterface<T>::operator T*& ()
{
    return (m_pointee);
}

template <class T>
T * VarInterface<T>::in()
{
    return (m_pointee);
}
