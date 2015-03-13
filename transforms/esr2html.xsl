<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:esr="http://common-criteria.rhcloud.com/ns/esr"
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fn="http://www.w3.org/2005/xpath-functions" 
version="1.0">

  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  

  <xsl:template match="/esr:ESR">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <style type="text/css">
      /*       { background-color: #FFFFFF; } */
      body { margin-left: 8%; margin-right: 8%; foreground: black; }
      td   { vertical-align: top; }
      div.section       { text-align: center; 
	  					margin-left: 0%; margin-top: 1em; margin-bottom: 1em; 
						border:2px solid #000000;  
						width: 100%;
						background-color: #FFFF99;
						font-family: arial, helvetica, sans-serif; font-weight: bold;
						box-shadow: 2px 2px 2px #888888;
      }

      table.intro       {  
	  					table-layout: fixed;
	  					width: 100%; margin-top: 1em; border: 1px solid black; 
						box-shadow: 2px 2px 2px #888888;
  						text-align:center; vertical-align:middle; 
						font-family: arial, helvetica, sans-serif; 
	  }
	  ul,ol             { margin-bottom: 0.5em; margin-top: 0.5em; }
	  li                { margin-bottom: 0.5em; margin-top: 0.25em; }

      
  </style>
  </head>

  <body>
        <xsl:apply-templates select="esr:intro" />
        <xsl:apply-templates select="//esr:section" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="esr:intro">
	<!-- table with CC logo-->
	<table class="intro">
	<tr>
	<td style="width: 50%;"><img style="max-width:100%;" src="images/cclogo.png" /></td>
	<td style="vertical-align: middle;">
	<b>Common Criteria Evaluation and Validation Scheme</b><p/>National Information Assurance Partnership (NIAP)
	</td>
	</tr>
	</table>
	<p/>
	<b>Title: </b><xsl:apply-templates select="esr:esrtitle" /><p/>
	<b>Maintained by: </b><xsl:apply-templates select="esr:maintainer" /><p/>
	<b>Unique Identifier: </b><xsl:apply-templates select="esr:identifier" /><p/>
	<b>Version: </b><xsl:apply-templates select="esr:version" /><p/>
	<b>Status: </b><xsl:apply-templates select="esr:status" /><p/>
	<b>Date of issue: </b><xsl:apply-templates select="esr:issuedate" /><p/>
	<b>Approved by: </b><xsl:apply-templates select="esr:approver" /><p/>
	<b>Supercedes: </b><xsl:apply-templates select="esr:superceded" /><p/>
  </xsl:template>
  


  <xsl:template match="esr:section">
    <div class="section"><xsl:value-of select="@title"/></div>
    <xsl:apply-templates />
  </xsl:template>
 
   <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
