
#include <cfs/com/corba/VarStringInterface.hpp>

 VarStringInterface::VarStringInterface ()
	: m_ptr (0)
{
}

 VarStringInterface::VarStringInterface (char * p)
	: m_ptr (p)
{
}

 VarStringInterface::VarStringInterface (const VarStringInterface & s)
	: m_ptr(0)
{
 if (s.m_ptr) m_ptr = string_dup (s.m_ptr);
}

 VarStringInterface::~VarStringInterface ()
{
	if (m_ptr) string_free (m_ptr);
}

 VarStringInterface & VarStringInterface::operator = (char * p)
{
	if (p != m_ptr) {
		if(m_ptr) string_free(m_ptr);
		m_ptr = p;
	}
	return *this;
}

 VarStringInterface & VarStringInterface::operator =(const VarStringInterface & s)
{
	if(this != &s) 
	{
		char* old_m_ptr = m_ptr;
		if(s.m_ptr != 0) m_ptr = string_dup(s.m_ptr);
		else m_ptr = 0;
		if(old_m_ptr) string_free(old_m_ptr);
	}
	return *this;
}

 VarStringInterface::operator char * ()
{
	return m_ptr;
}

 char& VarStringInterface::operator[] (ULong index)
{
	return m_ptr[index];
}

 char VarStringInterface::operator[] (ULong index) const
{
	return m_ptr[index];
}

char* VarStringInterface::string_alloc(::CORBA::ULong len)
 {
     char* str = new char[len+1];
     str[len] = '\0';
     return str;
 }

char* VarStringInterface::stringDup(const char* s)
{
  char* dest = ::VarStringInterface::string_alloc(strlen(s));
  return strcpy(dest, s);
}

void VarStringInterface::stringFree(char* s)
{
    delete [] s;
}
