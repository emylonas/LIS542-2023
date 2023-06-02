<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:d="http://UW-LIS-diaries/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p> Stylesheet to convert the a diary marked up according to the diaries.rng schema
                to HTML.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> May 10, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>
            
        </xd:desc>
    </xd:doc>
<!-- Styled marginalia <additions> to appear in gray text enclosed in [brackets] -->
<!--Added xls:for-each-group element to list of names and places.-->
<!-- Added xls:sort element to list of names and places. Final version sorts by xml:id-->
    <xsl:variable name="newline">
        <xsl:text> 
</xsl:text>
    </xsl:variable>
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="diaries.css"/>
            </head>
            
            <body>
                <h1>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </h1>
                <h1>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:author"/>
                </h1>
                <xsl:apply-templates/>
                
                
                <div>
                    <h1>List of Names</h1>
                    <p>
                        <ol>
                            <xsl:for-each-group select="//d:entries//d:name" group-by="@xml:id">
                                <xsl:sort select="."/>
                                <xsl:for-each select="current-group()" xml:space="preserve">
                                    <li>
                                        <xsl:value-of select="."/> (<xsl:value-of select="@role"/>)
                                    </li>
                                </xsl:for-each>
                            </xsl:for-each-group>
                        </ol>
                    </p>
                </div>
                
                <div>
                    <h1>List of Places</h1>
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:place" xml:space="preserve">
                                <xsl:sort select="." />
                                <li>
                                    <xsl:value-of select="."/>
                                </li></xsl:for-each>
                        </ol>
                    </p>
                </div>
            </body>
        </html>
        
    </xsl:template>
    
    
    <!-- ********************************************************  Metadata elements *************************************************************** -->
    <xsl:template match="d:journal">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:metadata">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:sourceInfo"/>
    <!-- Empty so that their content is hidden -->
    <xsl:template match="d:revisions"/>
    
    
    
    <!--   **************************************************** Diary Entries Strcture *********************************************************** -->
    
    
    <xsl:template match="d:entries"> 
        
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="d:entry"> 
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="d:p"> 
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    
    <!--   ****************************************** Phrase level elements and Milestone Elements ******************************************** -->
    
    <xsl:template match="d:entry/d:date">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <xsl:template match="d:date">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:name"> 
        <span class="name"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:place"> 
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:alternates"> 
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="d:addition"> 
        <span class="addition">[<xsl:apply-templates/>]</span>
    </xsl:template>
    
    <xsl:template match="d:cite">
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
    
    <xsl:template match="d:pb"> [<xsl:value-of select="@n"/>] </xsl:template>
    <!--  or  select="concat('page ',translate(@n, 'page0', ''))"  for a more elegant display -->
    
   <!-- New modifications start here -->
    
    <xsl:template match="d:q"> 
        "<xsl:apply-templates/>"
    </xsl:template>
    
    <xsl:template match="d:q/d:cite">
        <a href="{@ref}"><xsl:apply-templates/></a>
     </xsl:template>
    
    <!-- Catch all to see what we aren't handling -->
    
    <!-- <xsl:template match='*'>
        QQQ-element: <xsl:value-of select="name()"/>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>-->
    
</xsl:stylesheet>
