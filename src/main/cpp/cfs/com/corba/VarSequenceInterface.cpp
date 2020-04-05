
#include <cfs/com/corba/VarSequenceInterface.hpp>

using namespace cfs::com::corba;

template <class T>
VarSequenceInterface<T>::VarSequenceInterface()
    : m_pointee (nullptr)
{
}

template <class T>
VarSequenceInterface<T>::VarSequenceInterface(T * p)
    : m_pointee (p)
{
}

template <class T>
VarSequenceInterface<T>::VarSequenceInterface(const VarSequenceInterface<T>& t)
    : m_pointee(nullptr)
{
    if(t.m_pointee != nullptr)
    {
        m_pointee = new T(*t.m_pointee);
    }
}

template <class T>
VarSequenceInterface<T>::~VarSequenceInterface()
{
    if(m_pointee)
    {
        delete m_pointee;
    }
}

template <class T>
VarSequenceInterface<T> &
VarSequenceInterface<T>::operator=(T* t)
{
    if(t != m_pointee)
    {
        if(m_pointee)
        {
            delete m_pointee;
        }
        m_pointee = t;
    }

    return (*this);
}

template <class T>
VarSequenceInterface<T> &
VarSequenceInterface<T>::operator=(const VarSequenceInterface<T>& t)
{
    if(this != &t)
    {
        T* old_m_pointee = m_pointee;
        if(t.m_pointee != nullptr)
        {
            m_pointee = new T(*t.m_pointee);
        }
        else
        {
            m_pointee = nullptr;
        }
        if(old_m_pointee)
        {
            delete old_m_pointee;
        }
    }

    return (*this);
}

template <class T> inline T*
VarSequenceInterface<T>::operator->()
{
    return (m_pointee);
}
