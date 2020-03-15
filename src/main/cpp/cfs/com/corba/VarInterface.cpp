
#include <cfs/com/corba/VarInterface.hpp>

using namespace cfs::com::corba;

template <class T>
VarInterface<T>::VarInterface()
    : m_pointee (nullptr)
{
}
/*
template <class T>
VarInterface<T>::VarInterface(T * p)
    : m_pointee (p)
{
}

template <class T>
VarInterface<T>::VarInterface(const VarInterface<T>& t)
    : m_pointee(t.m_pointee)
{
    if (t.m_pointee)
    {
        t.m_pointee->_add_ref ();
    }
}

template <class T>
VarInterface<T>::~VarInterface()
{
    if(m_pointee)
    {
        m_pointee->_remove_ref();
    }
}

template <class T>
VarInterface<T> &
VarInterface<T>::operator=(T* t)
{
    if(m_pointee)
    {
        m_pointee->_remove_ref();
    }
    m_pointee = t;

    return (*this);
}

template <class T>
VarInterface<T> &
VarInterface<T>::operator=(VarInterface<T>& t)
{
    if(m_pointee)
    {
        m_pointee->_remove_ref();
    }

    m_pointee = t.in();

    if (m_pointee)
    {
        m_pointee->_add_ref ();
    }

    return (*this);
}

template <class T>
T *
VarInterface<T>::operator->()
{
    return (m_pointee);
}

template <class T>
VarInterface<T>::operator T*& ()
{
    return (m_pointee);
}

template <class T>
T *
VarInterface<T>::in()
{
    return (m_pointee);
}
*/
