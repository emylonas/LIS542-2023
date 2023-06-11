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
        <assert test="tei:lb">l element requires lb element</assert>
    </rule>
</pattern>

    <!-- 
        2. Write a rule to flag the @n attribute on <div> if its value doesn't begin with the string "poem." 
        In your example, the first poem is correct, but the second one is not.  
        -->
    
    <pattern>
        <rule context="tei:div">
            <assert test="starts-with(@n,'poem')">@n attribute on div element must begin with the string "poem"</assert>
        </rule>
    </pattern>
    
    
    
    <!-- 
        3. Write a rule to flag line numbers that are not contain 3 digits. 
        That is, n="0001" is correct. n="1" or n="02" are wrong 
    -->
    
    <pattern>
        <rule context="tei:l/@n">
            <assert test="string-length() = 4"> n in l must contain 4 digits</assert>
        </rule>
        
    </pattern>
   
    
    
    <!-- 
        4. Write a rule to flag when a <change> element in <RevisionDesc> has no content.
        HInt: One way to figure out if there is any text content in an element is to measure the length of the content. 
     -->
   
    <pattern>
        <rule context="tei:change">
            <assert test="text()">RevisionDesc must have content</assert>
        </rule>        
    </pattern>
    
   
    
    <!-- 
        5. Write a rule that checks if the @type attribute on the <div> element has one of the two values "sonnet" or "limerick."
    -->
    
    <pattern>
        <rule context="tei:div/@type">
            <assert test=". = 'sonnet' or . = 'limerick'">type attribute can only be 'sonnet' or 'limerick'</assert> 
        </rule>
    </pattern>
    <!--Stuck on this after using '|' instead of 'or', they are NOT  the same in this context!-->
    
    <!-- 
        6. This one is advanced! Write a rule to check that the lines in any sonnet have a @rhyme attribute
         Ex: <l n="0001" rhyme="a"><lb/>poetic line</l> 
         The limerick shouldn't have @rhyme attributes. HINT: think about XPath axes.
    -->
 
    <!-- for attribute div type=sonnet <- //div[@type='foo'] 
        (similar to //name[@role="clergymans"] from xpath assignment) -->
    <!-- test for @rhyme -->
    <!--keeping notes  to share thought process-->
    
    <pattern>
        <!--<rule context="tei:l::tei:div[@type='foo']">--> <!--Not quite-->
        <rule context="tei:l[ancestor::tei:div[@type='foo']]">
            <assert test="@rhyme">Sonnet must contain rhyme attribute</assert>
        </rule>
    </pattern>
    
    
    
    <!-- 
      7. This one is also advanced! Write a rule to check that each line in a poem is immediately followed by an lb element 
      You can add a second rule inside pattern 1 above, which checks that there is an <lb> inside each <l>element. 
   -->
    
    <pattern>
        <rule context="tei:l">
            <assert test="tei:*[1] = [tei:lb]">Line must begin w/ lb element</assert>
        </rule>       
    </pattern>
    <!--I would never have quessed that this was technically wrong. 
    Called it good after one test.
    Kudos to the student who validated w/ different markup-->
   
   <!-- 
       8. If you are enjoying this so far, think of something else that you might want to check using Schematron. Try to write the rule.
   -->
   
    <pattern>
        <rule context="tei:head">
            <assert test="contains(., 'by')">Head element must containt string 'by'</assert>
        </rule>        
    </pattern>
<!--    I originally wanted to use this to practice regular expressions,
    '.*\bby\b.*' and '\bby\b' to find string 'by' but it was flagging the Lear poem as well as the Shakespeare poem.
    This version doesn't use a regular expression and correctly flags the line it should've,
    but it's not as satisfying. I wonder what could be wrong?-->
    
    
</sch:schema>