/*************************************************************************
 * Copyright (c) 2013 eProsima. All rights reserved.
 *
 * This copy of FastBuffers is licensed to you under the terms described in the
 * FAST_BUFFERS_LICENSE file included in this distribution.
 *
 *************************************************************************/

package com.eprosima.fastbuffers.typecode;

import java.util.List;
import java.util.ArrayList;

import org.antlr.stringtemplate.StringTemplate;

import com.eprosima.fastbuffers.util.Pair;

public class ArrayTypeCode extends ContainerTypeCode
{
    public ArrayTypeCode()
    {
        super(TypeCode.KIND_ARRAY);
        
        m_dimensions = new ArrayList<String>();
    }
    
    @Override
    public String getTypename()
    {
        StringTemplate first = null, second = null, fin = null;
        String prevf = null, prevs = null;
        
        for(int count = 0; count < m_dimensions.size(); ++count)
        {     
            first = m_typesgr.getInstanceOf("type_" + Integer.toHexString(TypeCode.KIND_ARRAY) + "_first");
            second = m_typesgr.getInstanceOf("type_" + Integer.toHexString(TypeCode.KIND_ARRAY) + "_second");
            second.setAttribute("size", m_dimensions.get(count));
            
            if(prevf != null)
            {
                first.setAttribute("prev", prevf);
            }
            if(prevs != null)
            {
                second.setAttribute("prev", prevs);
            }
            
            prevf = first.toString();
            prevs = second.toString();
        }
        
        fin = getStringTemplate();
        fin.setAttribute("firs", prevf);
        fin.setAttribute("secon", prevs);
        fin.setAttribute("type", getContentTypeCode().getTypename());
        
        return fin.toString();
    }
    
    public void addDimension(String dimension)
    {
        m_dimensions.add(dimension);
    }
    
    public Pair<Integer, Integer> getMaxSerializedSize(int currentSize, int lastDataAligned)
    {
        int lcontainTypeSize = getContentTypeCode().getSize();
        int lcontainTypeAlign = 0;
        int larraySize = 1;
        
        // Element contained type.
        if(lcontainTypeSize > 4)
        {
            lcontainTypeAlign = (lcontainTypeSize - (currentSize % lcontainTypeSize)) & (lcontainTypeSize - 1);
        }
        
        // Calculate array size.
        for(int count = 0; count < m_dimensions.size(); ++count)
        {     
            larraySize *= Integer.parseInt(m_dimensions.get(count));
        }
        
        return new Pair<Integer, Integer>(currentSize + lcontainTypeAlign + (larraySize *  lcontainTypeSize), lcontainTypeSize);
    }
    
    public int getMaxSerializedSizeWithoutAlignment(int currentSize)
    {
        int lcontainTypeSize = getContentTypeCode().getSize();
        int larraySize = 1;
        
        // Calculate array size.
        for(int count = 0; count < m_dimensions.size(); ++count)
        {     
            larraySize *= Integer.parseInt(m_dimensions.get(count));
        }
        
        return currentSize + (larraySize * lcontainTypeSize);
    }
    
    private List<String> m_dimensions;
}
