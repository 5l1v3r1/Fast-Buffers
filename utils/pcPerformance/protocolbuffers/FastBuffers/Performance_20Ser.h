#ifndef _Performance_20SER_H_
#define _Performance_20SER_H_

#include "Performance_20.h"
#include "cdr/FastCdr.h"

/*!
 * @brief This class offers an interface to serialize/deserialize the defined types in the user's IDL file  using a eprosima::FastBuffer.
 */
class user_cpp_DllExport Performance_20Ser : public eprosima::FastCdr
{ 
public:
    /*!
     * @brief This constructor creates a Performance_20Ser object that could serialize/deserialize
     * the assigned buffer.
     *
     * @param buffer A reference to the buffer that contains or will contain the CDR representation.
     */
    Performance_20Ser(eprosima::FastBuffer &buffer);
    
    /*!
     * @brief This function serialize a type performance::Performance.
     * @param x Reference to a  that will be serialized in the buffer.
     * @return Reference to the Performance_20Ser object.
     * @exception NotEnoughMemoryException This exception is thrown trying to serialize in a position that exceed the internal memory size.
     * @exception BadParamException This exception is thrown trying to serialize in an invalid value.
     */
    inline Performance_20Ser& operator<<(const performance::Performance &x){return serialize(x);}

    /*!
     * @brief This function serialize a type performance::Performance.
     * @param x Reference to a  that will be serialized in the buffer.
     * @return Reference to the Performance_20Ser object.
     * @exception NotEnoughMemoryException This exception is thrown trying to serialize in a position that exceed the internal memory size.
     * @exception BadParamException This exception is thrown trying to serialize in an invalid value.
     */
    Performance_20Ser& serialize(const performance::Performance &x);

    /*!
     * @brief This function deserialize a type performance::Performance.
     * @param x Reference to the variable that will store the performance::Performance read from the buffer.
     * @return Reference to the Performance_20Ser object.
     * @exception NotEnoughMemoryException This exception is thrown trying to deserialize in a position that exceed the internal memory size.
     * @exception BadParamException This exception is thrown trying to deserialize in an invalid value.
     */
    inline Performance_20Ser& operator>>(performance::Performance &x){return deserialize(x);}

    /*!
     * @brief This function deserialize a type performance::Performance.
     * @param x Reference to the variable that will store the performance::Performance read from the buffer.
     * @return Reference to the Performance_20Ser object.
     * @exception NotEnoughMemoryException This exception is thrown trying to deserialize in a position that exceed the internal memory size.
     * @exception BadParamException This exception is thrown trying to deserialize in an invalid value.
     */
    Performance_20Ser& deserialize(performance::Performance &x);
};

#endif // _Performance_20SER_H_