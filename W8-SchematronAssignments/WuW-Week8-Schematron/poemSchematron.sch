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
    <rule context="tei:l">
        <assert test="tei:lb">
            Please add an lb element in each l element. 
        </assert> 
    </rule>
</pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    <pattern>
        <rule context="tei:div">
            <assert test="(starts-with(@n,'poem'))">
                The @n attribute value of the element div must begin with the string "poem". 
            </assert>
        </rule>
    </pattern>

    <!-- 
        3. Write a rule to flag line numbers that are not contain 3 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong 
        SHOULD CONTAIN PRECISELY FOUR DIGITS ====
    -->
    <pattern>
        <rule context="tei:l">
            <assert test="(string-length(@n)=4)">
                The element n must contain precisely four digits. 
            </assert>
        </rule>
    </pattern>

    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. 
     -->
    <pattern>
        <rule context="tei:change">
            <assert test="string-length(.)>0">
                There must be a log of changes made in this text area. 
            </assert>
        </rule>
    </pattern>
    
    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."
    -->
    <pattern>
        <rule context="tei:div">
            <assert test="@type = 'sonnet' or @type = 'limerick'">
                The @type attribute of the div element must contain either "sonnet" or "limerick" as a value. 
            </assert>
        </rule>
    </pattern>
    
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have an @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes.
        notes to self: we are using context to focus on the <l> element, and then to specify we qualify it using [] by denoting ancestor::tei:div, which is the parent element. Then we have to qualify WHICH div we want, so we qualify THAT using another [] and stating @type = 'foo' or 'limerick' or 'sonnet'. 
    -->
    <pattern>
        <rule context="tei:l[ancestor::tei:div[@type='foo']]">
            <assert test="@rhyme">
                Must have @rhyme. 
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="tei:l[ancestor::tei:div[@type='limerick']]">
            <assert test="@rhyme">
                Must have @rhyme. 
            </assert>
        </rule>
    </pattern>
   
    
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l> element. 
      
      note here that if you use = after [1] you are comparing content, strings inside elements, instead of an element to an element qua element. This is just something you do, it is a self reference of the element on the axis: I am here because I am here. 
   -->
    
    <pattern>
        <rule context="tei:l">
            <assert test="node()[1][self::tei:lb]">
                Element l MUST be followed IMMEDIATELY by lb element.
            </assert>
        </rule>
    </pattern> 
    
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
       
       Im gonna make up a rule: we need precisely 3 div elements (IE 3 poems). 
   -->
   
    <pattern>
        <rule context="tei:body">
            <assert test="count(self::tei:div)=3">
                Must have exactly three div elements, representing three distinct poems. 
            </assert>
        </rule>
        
    </pattern>
    
    <!-- 
       9. I'm making more stuff up just to see.
       Rule: head element must have a given attributes(s). I'm gonna choose source, since it is already within the TEI simple schema. I tried earlier to do @year but that was not an attribute that was defined under element <head>, so I switched out. 
   -->
    <pattern>
        <rule context="tei:head">
            <assert test="@source and @corresp">
                Head element must have attribute(s) @source and @corresp.
            </assert>
        </rule>
    </pattern>

    
</sch:schema>
















