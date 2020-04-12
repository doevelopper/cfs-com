
#ifndef CFS_COM_CORBA_VARSEQUENCEINTERFACE_HPP
#define CFS_COM_CORBA_VARSEQUENCEINTERFACE_HPP

#include <cfs/com/corba/CorbaIdlTypes.hpp>

namespace cfs::com::corba
{
    template <class T>
    class VarSequenceInterface
    {
    public:

        VarSequenceInterface ();
        VarSequenceInterface (T * p);
        VarSequenceInterface (const VarSequenceInterface<T> & seq);
        ~VarSequenceInterface ();
        VarSequenceInterface<T> & operator = (T * p);
        VarSequenceInterface<T> & operator = (const VarSequenceInterface<T> & seq);

        T * operator->();
        typename T::_subscript_type
        operator [] (::CORBA::ULong index)
        {
            assert (m_pointee);

            return m_pointee->operator[] (index);
        }
        typename T::_const_subscript_type
        operator [] (::CORBA::ULong index) const
        {
            assert (m_pointee);

            return ((const T *)m_pointee)->operator[] (index);
        }
    protected:

/** pointee */
        T * m_pointee;
    };

}
#endif
