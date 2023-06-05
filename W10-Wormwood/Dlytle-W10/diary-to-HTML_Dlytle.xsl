<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:d="http://UW-LIS-diaries/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p> Stylesheet to convert the a diary marked up according to the dlytle-diaries-W10.rng schema
                to HTML.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> June 03, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> darlene</xd:p>

        </xd:desc>
    </xd:doc>

    <!-- line break in output file; improves human readability of xml output -->
    <!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline">
        <xsl:text> 
</xsl:text>
    </xsl:variable>

    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <!-- The following matches the root element, and sets up the overall HTML structure. -->      
    <xsl:template match="/">
        <html>
            <!-- Title of Site -->
            <head>
                <title>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="diaries.css"/>
            </head>
            <!-- Content of Site -->
            <body>
                <h1>
                    Title: <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </h1>
                <h1>
                    Author: <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:author"/>
                </h1>
                <h1>
                   Publisher:  <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:publisher"/>
                </h1>
                <h1>
                    Number of Pages:<xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:length"/>
                </h1>

                <xsl:apply-templates/>
                <!-- Data Lists -->
                <div>
                    <h1>List of Names</h1>
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:name">
                                <li>
                                    <xsl:value-of select="."/>
                                    <xsl:if test="@role">
                                        (<xsl:value-of select="@role"/>)
                                    </xsl:if>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
                <div>
                    <h1>List of Places</h1>
                    <p>
                        <ol>
                                                       <xsl:for-each select="//d:entries//d:place" xml:space="preserve">
                                                                <li>
                                                                      <xsl:value-of select="."/>
                                                                    </li>
                                                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>


    <!--   Metadata elements -->
    <xsl:template match="d:journal">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- ?Question: Does supressing/not supressing the parent of Metadata affect whether it can be refered to in the header?-->
    <xsl:template match="d:metadata">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Not for users; empty so that their content is hidden -->
    <xsl:template match="d:sourceInfo"/>
    <xsl:template match="d:adminInfo"/>



    <!-- Diary Entries Strcture -->
    <xsl:template match="d:entries"> <!-- Match <entries> and keep going  -->
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:entry"> <!-- Match <entry>, surround each one with an HTML <div> element and keep going  -->
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="d:p"> <!-- Match <p>, surround each one with an HTML <p> element and keep going  -->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="d:marginalia"> <!-- Match <marginalia>, surround each one with an HTML <i> element and keep going  -->
        <i>
            In the Margins: <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="d:q"> <!-- Match <entry>, surround each one with an HTML <q> element and keep going  -->
        <q><xsl:apply-templates/></q>
    </xsl:template>
    
    <xsl:template match="d:cite">
        <a href="{@ref}">
                <xsl:apply-templates/>
            </a>
    </xsl:template>

    <!-- Phrase level elements and Milestone Elements -->

    <xsl:template match="d:entry/d:date">
        <!-- Match the <date> which is at the beginning of each entry. It is the child of <entry> -->
        <h2>
            <xsl:apply-templates/>
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
    
    <xsl:template match="d:illegible"> <!-- Match <illegible> and follow with ?, then keep going. -->
        <xsl:apply-templates/>?
    </xsl:template>
   
    <xsl:template match="d:del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- I modified this XSL file to count pages rather than paragraphs since that is what is marked up in the XML file. -->
    <xsl:template match="d:pb">   
        [<xsl:value-of select="replace(@n, 'p0?', 'p. ')"/>]
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ?Question What is this below here? -Darlene -->

    <!-- Catch all to see what we aren't handling -->
    <!-- <xsl:template match='*'>
        QQQ-element: <xsl:value-of select="name()"/>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>-->

</xsl:stylesheet>
