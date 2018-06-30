
#include <cfs/com/corba/UnboundedSequence.hpp>

using namespace cfs::com::corba;

template <class T>
T* UnboundedSequence<T>::allocbuf (ULong nelems)
{
        return new T [nelems];
}

template <class T>
void UnboundedSequence<T>::freebuf (T * buffer)
{
        if (buffer) delete [] buffer;
}

template <class T>
void UnboundedSequence<T>::copy( const UnboundedSequence<T>& seq)
{
        if (this == &seq) return;

        if (seq.m_max > m_max) {

                if (m_release) {
                        freebuf (m_buffer);
                }

                m_max = seq.m_max;
                m_length = seq.m_length;
                m_buffer = allocbuf (m_max);
                m_release = true;

        } else {
                m_length = seq.m_length;
        }

        for (ULong i = 0; i < m_length; i++) {
                m_buffer[i] = seq.m_buffer[i];
        }

        return;
}

template <class T>
UnboundedSequence<T>::UnboundedSequence()
        : m_max (0)
        , m_length (0)
        , m_release (false)
        , m_buffer (0)
{
}

template <class T>
UnboundedSequence<T>::UnboundedSequence(ULong max)
        : m_max (max)
        , m_length (0)
        , m_release (true)
{
        m_buffer = allocbuf(max);
}

template <class T>
UnboundedSequence<T>::UnboundedSequence (ULong max, ULong length, T* data, Boolean release)
        : m_max (max)
        , m_length (length)
        , m_release (release)
        , m_buffer (data)
{
        assert (m_length <= m_max);
}

template <class T>
UnboundedSequence<T>::UnboundedSequence (const UnboundedSequence<T>& seq)
        : m_max (0), m_length (0), m_release (false), m_buffer (0)
{
        copy(seq);
}

template <class T>
UnboundedSequence<T>::~UnboundedSequence ()
{
        if (m_release) freebuf (m_buffer);
}

template <class T>
UnboundedSequence<T>& UnboundedSequence<T>::operator=(const UnboundedSequence<T>& seq)
{
        copy(seq);
        return (*this);
}

template <class T>
ULong UnboundedSequence<T>::maximum () const
{
        return (m_max);
}

template <class T>
ULong UnboundedSequence<T>::length () const
{
        return (m_length);
}

template <class T>
void UnboundedSequence<T>::length (ULong length)
{
        if (length > m_max)
        {

                T * oldBuf = m_buffer;

                m_max = length;
                m_buffer = allocbuf (m_max);

                for (ULong i = 0; i < m_length; i++)
                {
                        m_buffer[i] = oldBuf[i];
                }

                if (m_release)
                {
                        freebuf (oldBuf);
                }

                m_release = true;
        }

        m_length = length;
}

template <class T>
T& UnboundedSequence<T>::operator [] (ULong index)
{
        assert (index < m_length);
        return (m_buffer[index]);
}

template <class T>
const T& UnboundedSequence<T>::operator [] (ULong index) const
{
        assert (index < m_length);
        return (m_buffer[index]);
}

template <class T>
const T& UnboundedSequence<T>::get (ULong index) const
{
        assert (index < m_length);
        return (m_buffer[index]);
}
