<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://purl.oclc.org/dsdl/schematron" >
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <!-- Schematron rules for a poem marked up with XML.-->
    
    <!-- Rule 1: There should never be less than one p element inside an pb element. -->
    <pattern>
        <rule context="tei:pb">
            <assert test="tei:p">Every <name/> must have an lb element </assert>
        </rule>
    </pattern>
    
    <!-- Rule 2: The value of the @n attribute on each pb should start with 'p'. -->
    <pattern>
        <rule context="tei:entries">
            <assert test="starts-with(@n,'p')"> The value of the @n attribute on each pb should start with 'p'.</assert>
        </rule>  
    </pattern>
    
    <!-- Rule 3: Line numbers(pb/@n) must have 3 digits. (fill out with leading zeros). -->
    <pattern>
        <rule context="tei:pb">
            <assert test="string-length(@n)=3">The line number sequence must contain four digits or more.</assert>
        </rule>
    </pattern>
    
    <!-- Rule 4: <name/> must have text content to describe the change. -->
    <pattern>
        <rule context="tei:change">
            <assert test="text()"><name/> must have text content.</assert>
        </rule>
        
    </pattern>
    
    <!-- Rule 5: The @unit attribute of the <name/> element must be page or line. --> 
    <pattern>
        <rule context="tei:length[@unit]">
            <assert test="contains(@unit, 'page') or (@unit, 'lines')"> The @unit attribute of the <name/> element must be page or line. </assert>
            <!-- Other options:
                 <assert test="matches(@unit, 'page|line')">using match</assert>
                 <assert test=".='page' or .='line'">
                 <assert test="@unit=('line', 'page')"> -->
        </rule>
    </pattern>
    
    <!-- Rule 6: <name/> elements that are descendants of <div> elements whose @type is equal to "sonnet" must have a @rhyme attribute. -->
    <pattern>
        <rule context="tei:quote[ancestor::tei:p[@saidBy]]">
            <!-- the context is <quote> which has a predicate that checks if has a <p> 
                ancestor. The <p>, in turn, has a predicate which checks if it has a @saidby with <text>. Note that it's possible to have nested predicates. -->
            <!-- Other options:
                <rule context="tei:p[@saidby='']//descendant::tei:quote"> -->
            <assert test="text()"><name/> must have text content.</assert>
        </rule>
    </pattern>
    
    <!-- Rule 7:First element of <name/> has to be an lb. -->
    <pattern>
        <rule context="tei:l">
            <assert test="node()[1][self::tei:lb]">first element of <name/> has to be an lb</assert>     
            <!-- Incorrect option:
                <assert test="tei:*[1] = tei:lb]">first element of <name/> has to be an lb</assert>
                unpredictable results happen because the = or eq operator expects a string comparison, and is looking for the content of the <lb> element, and not the element itself. -->
        </rule>
    </pattern>
</sch:schema>