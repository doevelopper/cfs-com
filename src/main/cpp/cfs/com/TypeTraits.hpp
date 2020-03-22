
#ifndef CFS_COM_TYPETRAITS_HPP
#define CFS_COM_TYPETRAITS_HPP

namespace cfs::com
{
    void* voidify(const volatile void* ptr) noexcept
    {
        return const_cast<void*>(ptr);
    }

    // #1, enabled via the return type
    template<class T>
    typename std::enable_if<std::is_trivially_default_constructible<T>::value>::type
    construct(T*)
    {
    }

    template<class T>
    typename std::enable_if<!std::is_trivially_default_constructible<T>::value>::type
    construct(T* p)
    {
        ::new(cfs::com::voidify(p)) T;
    }

    template<class T, class... Args>
    std::enable_if_t<std::is_constructible<T, Args&&...>::value> // Using helper type
    construct(T* p, Args&&... args)
    {
        ::new(cfs::com::voidify(p)) T(static_cast<Args&&>(args)...);
    }

    template<class T>
    void destroy(T*, typename std::enable_if<std::is_trivially_destructible<T>::value>::type* = 0)
    {}

    template<class T,
         typename std::enable_if<
             !std::is_trivially_destructible<T>{} &&
             (std::is_class<T>{} || std::is_union<T>{}),
            int>::type = 0>
    void destroy(T* t)
    {
        t->~T();
    }
    // #5, enabled via a type template parameter
    template<class T,
	    typename = std::enable_if_t<std::is_array<T>::value> >
    void destroy(T* t) // note: function signature is unmodified
    {
        for(std::size_t i = 0; i < std::extent<T>::value; ++i)
        {
            destroy((*t)[i]);
        }
    }

    template <class T>
    std::enable_if_t<(sizeof(T) <= sizeof(int))> f(T) {}

    template <class T>
    std::enable_if_t<(sizeof(T) > sizeof(int))> f(T) {}
}

#endif
