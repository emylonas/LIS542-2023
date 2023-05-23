<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://purl.oclc.org/dsdl/schematron" >
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <!-- 
      The text is green is an XML comment, which means it is for humans to read, but is ignored by any XML processor. 
       You can fill in your Schematron rules below each comment. They are merely there to help. 
    -->
    
    <!-- 
        1. Write a rule to flag an <l> element that doesn't have an lb element inside it. check tei
    -->

<pattern>
    <rule context="tei:l">
        <assert test="tei:lb">This l element needs an lb element</assert>
    </rule>
</pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    
    <pattern>
        <rule context="tei:div">
            <assert test="starts-with(@n,'poem')">n attribute on <name/> needs to start with poem</assert>
        </rule>
    </pattern>
    
    
    
    <!-- 
        3. Write a rule to flag line numbers that do not contain 4 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong   string length?
    -->
    
    <pattern>
        <rule context="tei:l/@n">
            <assert test="string-length(.)=4"> n attributes must be four digits</assert>
        </rule>
    </pattern>
    
    
    
    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. string length more than 0. use . to refer to element in context
     -->
   
    <pattern>
        <rule context="tei:change">
            <assert test="string-length() ne 0">Every <name/> element must contain content</assert>
        </rule>
    </pattern>
    
   
    
    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."
        using contains with sonnet or limerick as yy
        I know this isn't right but I can't figure out how to get sonnet and limerick both as optional @types to check for?? this works when
        I limit it to one of them but I can't find how to include both.
    -->
    
    <pattern>
        <rule context="tei:div/@type">
            <assert test="contains(.,'sonnet' or 'limerick')">div type must be sonnet or limerick</assert>
        </rule>
    </pattern>
    
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have a @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes. use [square brackets] from xpath assignment
         
    -->
    
    <pattern>
        <rule context="tei:l[ancestor::tei:div[@type='sonnet']]">
            <assert test="@rhyme">Sonnets must have rhyme attribute</assert>
        </rule>
    </pattern>
    
   
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l>element. 
      
      
   -->
    
    <pattern>
        <rule context="tei:l">
            <assert test="node()[1][self::tei:lb]">first element of <name/> has to be an lb</assert>
        </rule>
    </pattern>
    
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
   -->
   
    <pattern>
        <rule context="tei:div">
            <assert test="tei:head">Every poem requires a heading of title and author</assert>
        </rule>
    </pattern>
    
    
    
</sch:schema>