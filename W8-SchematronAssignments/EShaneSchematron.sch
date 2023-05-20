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
            <assert test="tei:lb">Every &lt;l&gt; element must contain an &lt;lb&gt; element</assert>
        </rule>
    </pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    
    <pattern>
        <rule context="tei:div/@n">
            <assert test="starts-with(.,'poem')">@n attributes must begin with 'poem.'</assert>
        </rule>
    </pattern>
    
    
    
    <!-- 
        3. Write a rule to flag line numbers that are not contain 3 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong 
    -->
    
    <pattern>
        <!-- 
         This rule just checks to see if the line number has at least 4 characters of any kind (does not enforce that they be digits rather than letters):
        <rule context="tei:l/@n">
            <assert test="string-length()gt 3">Line numbers (@n attributes) must have at least 4 digits.</assert>
        </rule> -->
        
        <rule context="tei:l/@n">
            <assert test="matches(.,'\d\d\d\d+')">Line numbers (@n attributes) must have at least 4 digits and only digits.</assert>
        </rule>
        
    </pattern>    
    
    
    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. 
     -->
    <pattern>
        <rule context="tei:revisionDesc/tei:change">
            <assert test="string-length()ne 0">Every &lt;change&gt; element must contain some content.</assert>
        </rule> 
    </pattern>   

    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."
    -->
    
    <pattern>
        <rule context="tei:div/@type">
            <assert test=".='sonnet' or .='limerick'">The @type attribute on a &lt;div&gt; element must have either "sonnet" or "limerick" as its value.</assert>
        </rule>
    </pattern>    
    
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have a @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes.
    -->
        <pattern> 
        <rule context="tei:div[@type='sonnet']//descendant::tei:l">
            <assert test="@rhyme">Sonnet lines must have a @rhyme attribute.</assert>
        </rule>
        <rule context="tei:div[@type='limerick']//descendant::tei:l">
            <assert test="not(@rhyme)">Limerick lines cannot have a @rhyme attribute.</assert>
        </rule>
    </pattern>   
    
    
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l>element. 
   -->
    
    <pattern>
        <rule context="tei:l">
            <assert test="tei:lb">Every &lt;l&gt; element must contain an &lt;lb&gt; element</assert>
        </rule>
        <rule context="tei:l">
            <assert test="*[1] = tei:lb">The first child of <name/> should be lb</assert>
        </rule>
    </pattern>
    
    
    
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
       
       This rule enforces the inclusion of a <name> element within the <head> for each poem (restricted to div/head in case you put more heads somewhere else, for some reason.
   -->
   
    <pattern>
        <rule context="tei:div/tei:head">
            <assert test="tei:name">The &lt;head&gt; element for each poem must contain a &lt;name&gt; element.</assert>
        </rule>
        
    </pattern>     
    
    
    
</sch:schema>