<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:d="http://W10-Wormwood-Source-WW.xml" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p> Stylesheet to convert the a diary marked up according to the diaries.rng schema
                to HTML.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> May 10, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>
            
        </xd:desc>
    </xd:doc>
    
    <!-- line break in output file; improves human readability of xml output -->
    <!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline">
        <xsl:text> 
</xsl:text>
    </xsl:variable>
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/">
        
        <!-- The following matchest the root element, and sets up the overall HTML structure. -->
        <html>
            <head>
                <title>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="W10-Diaries-WW.css"/>
            </head>
            <body>
                <h1>
                    <span class="title">
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                    </span>
                </h1>
                <h1>
                    <span class="author">
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:author"/>
                    </span>
                </h1>
                <xsl:apply-templates/>
                
                <div>
                    <h1>List of Names</h1>
                    <p>
                        <ol>
                            <xsl:for-each-group select="//d:entries//d:name" group-by=".">
                                <li>
                                    <xsl:choose>
                                        <xsl:when test="string-length(@role)= 0">
                                            <xsl:value-of select="."/> (N/A)
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="."/> (<xsl:value-of select="@role"/>) 
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </li>
                            </xsl:for-each-group>
                        </ol>
                    </p>
                </div>
                
                
                
                
                
           <!--     <xsl:template match="/">
                    <products>
                        <xsl:for-each select="product[not(@sku=preceding-sibling::product/@sku)]">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </products>
                </xsl:template>   
           FROM THE OREILLY TEXTBOOK on how to remove duplicates in a list, but its for ATTRIBUTES...  -->
        
                
          
                
                <!-- WILLIAM: I want to add an N/A to every () in the names list for those names that dont have any roles -->
                <!-- WILLIAM: I have a question here, why is it that when I deleted the big white spaces in front of lines 49-54, the double spacing in the html rendered website for the list of names dissappeared? Also, how do I delete the big double space after the names list? Why is that big double space still there, whereas the white space after List of Places is only a single space?   -->
                
                <div>
                    <h1>List of Places</h1>
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:place" xml:space="preserve">
                                <li>
                                    <xsl:value-of select="."/> (<xsl:value-of select="@type"/>)
                                </li>
                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
            </body>
        </html> --> 
        
    </xsl:template>
    
    
    <!-- **********************************************************************  Metadata elements ********************************************************************** -->
    <xsl:template match="d:journal">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- We are going to suppress all output from the metadata elements for now. Keeping the parent element around just in case we decide to use it later -->
    
    <xsl:template match="d:metadata">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:sourceInfo"/>
    <!-- Empty so that their content is hidden -->
    <xsl:template match="d:revisions"/>
    
    
    
    <!--   ******************************************************************** Diary Entries Strcture ******************************************************************** -->
    
    
    <xsl:template match="d:entries"> <!-- Match <entries> and keep going  -->
        
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="d:entry"> <!-- Match <entry>, surround each one with an HTML <div> element and keep going  -->
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="d:p"> <!-- Match <entry>, surround each one with an HTML <p> element and keep going  -->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--   ******************************************************* Phrase level elements and Milestone Elements *************************************************** -->
    
    <xsl:template match="d:entry/d:date">
        <!-- Match the <date> which is at the beginning of each entry. It is the child of <entry> -->
        <h2>
            <span class="date">
            <xsl:apply-templates/>
            </span>
        </h2>
    </xsl:template>
    
    <xsl:template match="d:date">
        <!-- Match all other dates. This could be qualified to only match <date> in <p>.-->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:name"> <!-- Enclosing in HTML span element with class attribute so CSS formatting can be applied. -->
        <span class="name"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:place"> <!-- Enclosing in HTML span element with class attribute so CSS formatting can be applied. -->
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:alternates"> <!-- Match <alternate> and keep going. -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:original | d:abbr"> <!-- Enclosing in HTML span element with class attribute to allow js to hide and show orig/new spelling. -->
        <span class="original"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:corr | d:expan"> <!-- Enclosing in HTML span element with class attribute to allow js to hide and show orig/new spelling. -->
        <span class="modern"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:pb"> 
        <span class="pb">
        [<xsl:copy-of select="node()"/>]
        </span>
    </xsl:template>
    <!-- WILLIAM: I also capitalized the P on page by deleting page0 and just adding in Page          notes:   [<xsl:value-of select=""/>]  "concat('',translate(@n, 'page0', 'Page'))"/>]     -->
    
    <!--  or  select="concat('page ',translate(@n, 'page0', ''))"  for a more elegant display -->
    
    <!--
    <xsl:template match="d:q">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
    </xsl:template> 
    -->
    
    <xsl:template match="d:q">
        "<xsl:apply-templates/>"
    </xsl:template>
    
    <xsl:template match="d:cite">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}">
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- THE HYPERLINK IS NOT WORKING, HOW TO FIX?
        <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="link">
        <a href="{@url}"><xsl:apply-templates/></a>
    </xsl:template>
</xsl:stylesheet>  
    THIS CODE IS FROM STACKOVERFLOW, how to use? 
    
    UPDATE: nevermind this note section, I got the Howard hyperlink to work.-->
    

    <!-- WILLIAM: testing the deletion of the two periods after date element-->
    <!-- WILLIAM: The two . periods after the dates were getting annoying since they create a whole big new line, so I want to delete them. I assume this was a typo in the input of the xml document, but I want to see if I can delete it using xsl and not doing it manually. -->
    <xsl:template match="d:entry/text()[normalize-space(.) != '']"/>
    
    
    
    <!-- Catch all to see what we aren't handling -->
    
    <!-- <xsl:template match='*'>
        QQQ-element: <xsl:value-of select="name()"/>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>-->
    
</xsl:stylesheet>