package com.eprosima.ebuffers.typecode;

import org.antlr.stringtemplate.StringTemplate;

import com.eprosima.ebuffers.util.Pair;

public class EnumTypeCode extends MemberedTypeCode
{
    public EnumTypeCode(String scope, String name)
    {
        super(TypeCode.KIND_ENUM, scope, name);
    }
    
    public void addMember(EnumMember member)
    {
        addMember((Member)member);
    }

    @Override
    public String getTypename()
    {
        StringTemplate st = getStringTemplate();
        st.setAttribute("name", getScopedname());
        return st.toString();
    }
    
    public Pair<Integer, Integer> getMaxSerializedSize(int currentSize, int lastDataAligned)
    {
        int size = getSize();
        
        if(size <= lastDataAligned)
        {
            return new Pair<Integer, Integer>(currentSize + size, size);
        }
        else
        {
            int align = (size - (currentSize % size)) & (size - 1);
            return new Pair<Integer, Integer>(currentSize + size + align, size);
        }
    }
    
    public int getMaxSerializedSizeWithoutAlignment(int currentSize)
    {
        return currentSize + getSize();
    }
    
    protected int getSize()
    {    
        return 4;
    }

}
