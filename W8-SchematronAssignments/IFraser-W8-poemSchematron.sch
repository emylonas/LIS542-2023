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
        <assert test="count(tei:lb) gt 0">All l's need to contain an lb element.</assert>
    </rule>
</pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    
    <pattern>
       <rule context="tei:div">
           <assert test="starts-with(@n,'poem')">All @n's need to begin with "poem".</assert>
       </rule> 
    </pattern>
    
    
    
    <!-- 
        3. Write a rule to flag line numbers that are not contain 3 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong -->
    
    <pattern>
        <rule context="tei:l/@n">
            <assert test="string-length() gt 3">All line numbers must contain more than 3 digits.</assert> <!-- because the instructions contained a bit of a typo "Flag numbers that are not contain 3 digits", I wasn't sure if this was meant to mean that all lines have to contain at least 3 digits or more than 3 digits. So I went with the latter, as it meant that all @n attributes that didn't match were called out, including both n=010 and n=13. Whereas, if I chose the former (containing at least 3 digits), n=010 would still be considered valid despite it being out of sync/order with the rest of the @n attributes. Hopefully this is okay!--> 
        </rule>
    </pattern>
    
    
    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. 
     -->
   
    <pattern>
        <rule context="tei:revisionDesc/tei:change">
            <assert test="string-length() gt 0">Change element cannot be empty!</assert>
        </rule>
    </pattern>
    
   
    
    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."
    -->
    
    <pattern>
        <rule context="tei:div">
            <assert test="@type='sonnet' or @type='limerick'">Type must be either "sonnet" or "limerick".</assert>
        </rule>
    </pattern>
    
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have a @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes.
    -->
    
    <pattern>
        <rule context="tei:div[@type='sonnet']//tei:l[1]">
            <assert test="@rhyme">All sonnets require a @rhyme attribute!</assert> <!-- Tested by renaming first poem from 'foo' to 'sonnet' and then removing the @rhyme attribute to see if flagged. It was! Additionally, this rule should not apply to/affect limericks due to its context. However perhaps an additional rule flagging any limerick lines that do contain a @rhyme attribute might also help. But I believe this would require a second separate rule, and the instructions only referred to a single rule. " -->
        </rule>
    </pattern>
    
    
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l>element. 
   -->
    
    <pattern>
        <rule context="tei:l">
            <assert test="tei:lb">All lines must have a lb element!</assert>
        </rule>
        
    </pattern>
    
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
   -->
   
    <pattern>
        <rule context="tei:head">
            <assert test="contains(.,'Sonnet') or contains(.,'Limerick')">Poem-type must be mentioned in head element (remember to capitalize the first letter)!</assert> <!--I added a rule that all head elements must include the type of poem being encoded, along with a note that the type must be capitalized because it is case sensitive. I know this is already taken care of in the <div> element @type attribute, but it was the only other thing I could think to add at the moment :) -->
        </rule>
    </pattern>
    
    
    
</sch:schema>