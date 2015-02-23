<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
xmlns:dc="http://purl.org/dc/elements/1.1/" 
xmlns:xhtml="http://www.w3.org/1999/xhtml">

<!-- This style sheet takes as input a Protection Profile expressed in XML and
	outputs a table of the SFRs and SARs. -->
	

  <!-- Put all common templates into ProtectionProfileCommons -->
  <!-- They can be redefined/overridden  -->
  <xsl:include href="ppcommons.xsl"/>

  <!-- release variable, overridden to "final" for release versions -->
  <xsl:param name="release" select="'draft'"/>

  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:template match="/cc:PP">
    <html>
      <style type="text/css">
		h1   { text-align: left; font-size: 200%;  margin-top: 2em; margin-bottom: 2em;
             font-family: verdana, arial, helvetica, sans-serif;
             margin-bottom: 1.0em; }
		h1.title { text-align: center; }
		h2   { font-size: 125%;
             border-bottom: solid 1px gray; margin-bottom: 1.0em;
             margin-top: 2em; margin-bottom: 0.75em;
             font-family: verdana, arial, helvetica, sans-serif; }
        table.revisionhistory
        {
			margin: auto; margin-top: 1em; border-collapse:collapse;  }
        }
		tr.header
		{
			border-bottom: 3px solid gray; padding: 8px 8px; text-align:left; font-weight: bold;
		} 
        table, th, td
        {
			border-collapse: collapse;
            border: 2px solid #dcdcdc;
            border-left: none;
            border-right: none;
            vertical-align: top;
			text-align: left;
            padding: 2px;
            font-family: verdana,arial,sans-serif;
            font-size:14px;
			padding-right: 20px; 
        }

        pre {
            white-space: pre-wrap;
            white-space: -moz-pre-wrap !important;
            word-wrap:break-word;
        }
		div.title
		{ 
			text-align: center; font-size: xx-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			<!--border-bottom: solid 1px gray; -->
			margin-left: 8%; margin-right: 8%; 
		}
		div.center	{ display: block; margin-left: auto; margin-right: auto; text-align:center; }
		div.intro
		{ 
			text-align: left; font-size: normal; 
            font-family: verdana,arial,sans-serif;
			margin-left: 12%; margin-right: 12%; 
			padding-top: 1em;
		}
		div.tabletitle, div.componenttitle
		{ 
			text-align: left; font-size: x-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			margin-top: 3em;
			border-top: solid 2px gray; 
			border-bottom: solid 2px gray; 
			padding-bottom: 0.25em; padding-top: 0.25em; }

		div.componenttitle
		{ 
            background-color: #dedede;
		}
	    div.appnote    { margin-left: 0%; margin-top: 1em; }
		td.tabletitle
		{ 
			text-align: left; font-size: x-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			margin-top: 6em;
			border-top: solid 2px gray; 
			border-bottom: solid 2px gray; 
			padding-bottom: 0.25em; padding-top: 1.25em;
		}
		td.element, td.elementidstyle
		{ 
			padding-top: 1em;
			padding-bottom: 2em;
			padding-right: 1em;
		}
		td.elementidstyle
		{ 
			font-weight: bold;
            font-family: verdana,arial,sans-serif;
		}
		a.abbr:link {color:black; text-decoration:none;}
		a.abbr:visited {color:black; text-decoration:none;}
		a.abbr:hover {color:blue; text-decoration:none;}
		a.abbr:hover:visited {color:purple; text-decoration:none;}
		a.abbr:active {color:red; text-decoration:none;}

    	</style>

		<head>
			<title>Requirements for Vetting Mobile Apps from the Protection Profile for Application Software</title>
		</head>
		<body>
		<h1 class="title">
			Requirements for Vetting Mobile Apps from the
			<br/><i>Protection Profile for Application Software</i>
		</h1>
		<div class="center">
			<img src="images/niaplogo.png" />
			<p/>Version: <xsl:value-of select="//cc:ReferenceTable/cc:PPVersion" />
			<p/><xsl:value-of select="//cc:ReferenceTable/cc:PPPubDate" />
			<p/><b><xsl:value-of select="//cc:PPAuthor" /></b>
		</div>
		<h2>Revision History</h2>
		<div class="center">
			<table class="revisionhistory">
				<tr class="header">
					<th>Version</th>
					<th>Date</th>
					<th>Comment</th>
				</tr>
				<xsl:for-each select="cc:RevisionHistory[@role=$release]/cc:entry">
					<tr>
					<td>
					<xsl:value-of select="cc:version" />
					</td>
					<td>
					<xsl:value-of select="cc:date" />
					</td>
					<td>
					<xsl:value-of select="cc:subject" />
					</td>
					</tr>
				</xsl:for-each>
			</table>
		</div>
		<h2>Introduction</h2>
		<div class="intro">
			<b>Purpose.</b> This document presents functional and
			assurance requirements found in the <i>Protection Profile for Application
			Software</i> which are appropriate for vetting mobile application software
			("apps") <b>outside</b> formal Common Criteria (ISO/IEC 15408) evaluations.  Common
			Criteria evaluation, facilitated in the U.S. by the National Information
			Assurance Partnership (NIAP), is required for IA and IA-enabled products in
			National Security Systems according to CNSS Policy #11. Such evaluations, including
			those for mobile apps, must use the complete
			Protection Profile.  However, even apps without IA functionality may
			impose some security risks, and concern about these risks has motivated the
			vetting of such apps in government and industry.  
			<p/>
			<b>Using this document.</b> This representation of the Protection Profile includes:
			<ul> 
			<li><a href="#SFRs"><i>Security Functional Requirements</i></a> for use in evaluation.  These are featured without the formal
			Assurance Activities specified in the Protection Profile, as evaluation methods may vary
			outside the formal Common Criteria. 
			<p/> It also includes, in
			tables shown later, particular types of security functional requirements that are not strictly required in all cases.
			These are:</li>
			<p/>
				<ul>
				<li><a href="#selbasedSFRs"><i>Selection-based Security Functional Requirements</i></a> which become required when certain selections are made inside the regular
				Security Functionality Requirements (as indicated by the <b>[selection:]</b> construct).</li>
				<li><a href="#objSFRs"><i>Objective Security Functional Requirements</i></a> which are highly desired but not yet widely-available in commercial technology.</li>
				<li><a href="#optSFRs"><i>Optional Security Functional Requirements</i></a> which are available for evaluation and which some customers may insist upon.</li>
				</ul>
			
			<p/>
			<li><a href="#SARs"><i>Security Assurance Requirements</i></a> which are still practical without the close developer cooperation
			expected during a formal Common Criteria evaluation.  The security assurance requirements are a carefully-chosen subset
			from the Protection Profile.</li>
			</ul>
			<p/>
			In addition to providing these security requirements for vetting
			apps, this document provides a basis for discussion and consideration
			of the vetting provided by commercially-available app stores.  
			This document does not imply to Authorizing Officials that the vetting provided by 
			commercially-available app stores is either adequate or inadequate for the context in which they
			must weigh risks.  Rather, it is intended to help inform and support decision-making with regard to
			investment in app vetting processes.
			<p/>
		</div>
			<br/>

			<div class="tabletitle" id="SFRs">
				Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[not(@status)]"/>
			</table>
			<!-- <xsl:apply-templates select="//cc:f-component[not(@status='sel-based')]"/> -->

			<div class="tabletitle" id="SARs">
				Security Assurance Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:a-element[@id='alc_cmc.1.1c' or @id='ate_ind.1.2e' or @id='ava_van.1.1c' or @id='ava_van.1.2e']"/>
			</table>
	
			<div class="tabletitle" id="selbasedSFRs">
				Selection-Based Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='sel-based']"/>
			</table>


			<div class="tabletitle" id="objSFRs">
				Objective Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='objective']"/>
			</table>

			<div class="tabletitle" id="optSFRs">
				Optional Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='optional']"/>
			</table>

		</body>
		</html>
	</xsl:template>

	<xsl:template match="cc:f-component | cc:a-component">
		<xsl:variable name="componentid" select="translate(@id,$lower,$upper)" />	
		<div id="{$componentid}" class="componenttitle"><a class="abbr" href="#{$componentid}"><xsl:value-of select="@name"/></a></div>
		<table>
		<xsl:apply-templates select=".//cc:f-element | .//cc:a-element"/>
		</table>
	</xsl:template>

	<xsl:template match="cc:f-element | cc:a-element">
		<xsl:variable name="elementid" select="translate(@id,$lower,$upper)" />	
		<xsl:variable name="componentid" select="translate(../@id,$lower,$upper)" />	
		<!-- this will result in duplicate IDs for TRs (as link targets), but this does not create a problem in practice -->
		<tr id="{$componentid}">
		    <td id="{$elementid}" class="elementidstyle"><a class="abbr" href="#{$elementid}"><xsl:value-of select="$elementid"/></a></td>
			<td class="element"><xsl:apply-templates select="cc:title"/><br/>
				 <xsl:choose>
				 <xsl:when test="@status='objective'">
       		        <p/><i><b>This is currently an objective requirement.
					<xsl:if test="@targetdate">It is targeted for <xsl:value-of select="@targetdate"/>.</xsl:if></b></i>
					<br/>
         		 </xsl:when>
       		     <xsl:when test="@status='sel-based'">
        		     <p/><b><i>This is a selection-based requirement.
					 Its inclusion depends upon selection in 
					<xsl:for-each select="cc:selection-depends">
        				<xsl:value-of select="translate(@req, $lower, $upper)" />
						<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
					</xsl:for-each>.
			 		</i></b>
					<br/>
					<br/>
         		 </xsl:when>
				 </xsl:choose>

				<xsl:apply-templates select="cc:note[@role='application']"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="cc:title">
	      		<xsl:apply-templates />
	</xsl:template>

  <xsl:template match="cc:subaactivity">
    <div class="subaact">
      <i>
        <b>For <xsl:call-template name="OSabbrev2name"><xsl:with-param name="osname" select="@platform" /></xsl:call-template>:
	  </b>
      </i>
      <xsl:apply-templates />
    </div>
  </xsl:template>

	<!-- getting rid of XHTML namespace -->
	<xsl:template match="xhtml:*">
		<xsl:element name="{local-name()}">
 			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="cc:aactivity">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>



	
</xsl:stylesheet>
