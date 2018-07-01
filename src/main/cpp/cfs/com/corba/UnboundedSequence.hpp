
#ifndef CFS_COM_CORBA_UNBOUNDEDSEQUENCE_HPP
#define CFS_COM_CORBA_UNBOUNDEDSEQUENCE_HPP

namespace cfs::com::corba
{

    class UnboundedSequence
    {
    using T& = refType;
    using const T& = constRefType;
    public
    UnboundedSequence(ULong max);
    UnboundedSequence(ULong max, ULong length, T* value, Boolean release = false);
    UnboundedSequence(const UnboundedSequence<T>& );
    UnboundedSequence<T>& operator=(const UnboundedSequence<T>& seq);

    ULong max () const;
    ULong length() const;
    void length (ULong length);
    T& operator [] (ULong index);
    const T& operator [] (ULong index) const;
    const T& get (ULong index) const;

/** allocates a buffer of T elements */
    static T * alloccateBuffer (ULong nelems);

/** deletes a buffer of T elements */
    static void freebuf (T * buffer);

    protected:

    private:

        void copy(const UnboundedSequence<T>& seq);
        T* m_buffer;
        Boolean m_release;
        ULong m_length;
        ULong m_max;
    };

}
#endif
