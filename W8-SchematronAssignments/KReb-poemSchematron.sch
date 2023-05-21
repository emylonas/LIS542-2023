<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://purl.oclc.org/dsdl/schematron" >
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <!-- 
      The text is green is an XML comment, which means it is for humans to read, but is ignored by any XML processor. 
       You can fill in your Schematron rules below each comment. They are merely there to help. 
    -->
    
    <!-- 
        1. Write a rule to flag an <l> element that doesn't have an lb element inside it. 
    -->

<pattern>
    <rule context="tei-1">
        <assert test="tei-1b">i "1" element must contain a "1b" element </assert>
    </rule>
</pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    
    <pattern>
        <rule context="tei:div/@n">
            <assert test="starts-with(@N, poem)"> All @n attributes must start with "poem" </assert>
            
        </rule>
        
    </pattern>
    
    
    
    <!-- 
        3. Write a rule to flag line numbers that are not contain 3 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong 
    -->
    
    <pattern>
        
        <rule context="tei-1/@n">
            <assert test="string-length()=4"> n element must have 4 digits </assert>
                
        </rule>
    </pattern>
    
    
    
    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. 
     -->
   
    <pattern>
       <rule context="tei:RevisionDesc/change">
           <assert test= "string-length()=0">RevisionDesc change element must have content</assert>
       </rule> 
        
    </pattern>
    
   
    
    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."

    -->
    
    <pattern>
        <rule context="tei:div/@type">
            <assert test= "contains('limerick','sonnet')"> @type value must be limerick or sonnet </assert>
        </rule>
        
    </pattern>
    
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have a @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes.
    -->
    
    <pattern>
        <rule context="tei-1[ancestor::tei:div[@type='sonnet']]">
            <assert test="@rhyme">Sonnet lines must rhyme</assert>
        </rule>
        
    </pattern>
    
    
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l>element. 
      **Note to Self: This one was really challenging and I think I understand the role of the child element but I think some feedback on this one in particular would be great**
   -->
    
    <pattern>
        <rule context="tei-1">
            <assert test="child::node()=tei-1b"> All '1' elements must be followed by a '1b' element</assert>
        </rule>
        
    </pattern>
    
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
   -->
   
    <pattern>
        
        
    </pattern>
    
    
    
</sch:schema>