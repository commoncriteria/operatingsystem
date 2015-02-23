<?xml version="1.0" encoding="utf-8"?>
<!-- 
    Stylesheet for Protection Profile Schema  
    Authors: Dennis Orth, Jeff Blank
    Version: 9 Jan 2014
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cc="http://common-criteria.rhcloud.com/ns/cc" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:param name="appendicize"/>
  
  <xsl:variable name="bool_appendicize" select="($appendicize = 'true') or ($appendicize = '1')" />
  
  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <!-- Put all common templates into ProtectionProfileCommons -->
  <!-- They can be redefined/overridden  -->
  <xsl:include href="ppcommons.xsl"/>
  
  <xsl:template match="/cc:PP">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <style type="text/css">
      /*       { background-color: #FFFFFF; } */
      body { margin-left: 8%; margin-right: 8%; foreground: black; }
      h1   { text-align: left; font-size: 200%;  margin-top: 2em; margin-bottom: 2em;
             font-family: verdana, arial, helvetica, sans-serif;
             margin-bottom: 1.0em; }
	  h1.title { text-align: center; }
      h2   { font-size: 125%;
             border-bottom: solid 1px gray; margin-bottom: 1.0em;
             margin-top: 2em; margin-bottom: 0.75em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h3   { font-size: 110%; margin-bottom: 0.25em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h4   { margin-left: 0%; font-size: 100%; margin-bottom: 0.75em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h5,h6 { margin-left: 6%; font-size: 90%; margin-bottom: 0.5em;
              font-family: verdana, arial, helvetica, sans-serif; }
      p    { margin-bottom: 0.2em; margin-top: 0.2em; }
      pre  { margin-bottom: 0.5em; margin-top: 0.25em; margin-left: 3%;
             font-family: monospace; font-size: 90%; }
      ul   { margin-bottom: 0.5em; margin-top: 0.25em; }
      td   { vertical-align: top; }
      dl   { margin-bottom: 0.5em; margin-top: 0.25em; }
      dt   { margin-top: 0.7em; font-weight: bold; 
             font-family: verdana, arial, helvetica, sans-serif; }
      
      a.abbr:link {color:black; text-decoration:none;}
      a.abbr:visited {color:black; text-decoration:none;}
      a.abbr:hover {color:blue; text-decoration:none;}
      a.abbr:hover:visited {color:purple; text-decoration:none;}
      a.abbr:active {color:red; text-decoration:none;}
      
      *.simpleText   { margin-left: 10%; }
      *.propertyText { margin-left: 10%; margin-top: 0.2em; margin-bottom: 0.2em }
      *.toc      { background: #FFFFFF; }
      *.toc2         { background: #FFFFFF; }
      div.comp        { margin-left: 8%; margin-top: 1em; margin-bottom: 1em; }
      div.appnote    { margin-left: 0%; margin-top: 1em; }
      
      div.subaact       { margin-left: 0%; margin-top: 1em;  }

      div.statustag { margin-left: 0%; margin-top: 1em; margin-bottom: 1em;	padding: 1em;
				border:2px solid  #888888; border-radius:3px; }
				
      div.toc        { margin-left: 8%; margin-bottom: 4em;
                       padding-bottom: 0.75em; padding-top: 1em;
                       padding-left: 2em; padding-right: 2em; }
      span.SOlist   {   font-size: 90%; font-family: verdana, arial, helvetica, sans-serif; }
      h2.toc         { border-bottom: none; margin-left: 0%; margin-top: 0em; }
      p.toc          { margin-left: 2em; margin-bottom: 0.2em; margin-top: 0.5em; }
      p.toc2         { margin-left: 5em; margin-bottom: 0.1em; margin-top: 0.1em; }
      table          { margin: auto; margin-top: 1em; border-collapse:collapse; /*border: 1px solid black;*/ }
      td   { text-align: left; padding: 8px 8px; }
      th   { padding: 8px 8px; }
      tr.header            { border-bottom: 3px solid gray; padding: 8px 8px; text-align:left; font-weight: bold; /*font-size: 90%; font-family: verdana, arial, helvetica, sans-serif; */ }
      table tr:nth-child(2n+2) { background-color: #F4F4F4; }
      div.center	{ display: block; margin-left: auto; margin-right: auto; text-align:center; }
      div.figure	{ display: block; margin-left: auto; margin-right: auto; text-align:center; margin-top: 1em; }
      
      div.aact { 
      display:table-cell; vertical-align:middle; padding-top:10px
      }
      div.aact div.expanded {
      height:auto;
      margin-left: 0%; 
      margin-top: 1em;
      margin-bottom: 1em;
      float: left;
      padding: 1em;
      border:2px solid  #888888; border-radius:3px;
      }
      
      div.aact > a > span { vertical-align:middle;  color:black; text-decoration: none; font-size: 100%; font-weight: bold; /*font-family: verdana, arial, helvetica, sans-serif; */ }
      
      div.aact > a         { color: black; text-decoration: none;  }
      div.aact > a:link    { color: black; text-decoration: none;  }
      div.aact > a:visited { color: black; text-decoration: none;  }
      div.aact > a:hover   { color: black; text-decoration: none;  }
      div.aact > a:active  { color: black; text-decoration: none;  } 
      
      .show {
      display: none; 
      }
      .hide:target + .show {
      display: inline; 
      }
      .hide:target {
      display: none; 
      }
      .hide:target ~ div.expanded {
      display:inline; 
      }
      
      @media screen {
        *.reqid { position:absolute; font-size: 90%; 
                  font-family:   verdana, arial, helvetica, sans-serif; }
        *.req { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }
        *.reqdesc { display:inline-block; margin-left: 20%; }
        div.aact div.expanded{ display: none; }
        div.statustag {box-shadow: 4px 4px 3px #888888; }
      }

      @media print {
          *.reqid   { font-size: 90%; font-family: verdana, arial,
                helvetica,
                sans-serif; }
           *.req    { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }
           *.reqdesc  { margin-left: 20%; }
           div.aact div.expanded{
               display: block;
           }
      }
      
      
  </style>
      </head>
      <body>
        <h1 class="title">
          <xsl:value-of select="//cc:ReferenceTable/cc:PPTitle" />
        </h1>
        <div class="center">
          <img src="images/niaplogodraft.png" />
          <p />Version: <xsl:value-of select="//cc:ReferenceTable/cc:PPVersion" /><p /><xsl:value-of select="//cc:ReferenceTable/cc:PPPubDate" /><p /><xsl:value-of select="//cc:PPAuthor" /></div>
        <h2>Revision History</h2>
        <table>
          <tr class="header">
            <th>Version</th>
            <th>Date</th>
            <th>Comment</th>
          </tr>
          <xsl:for-each select="cc:RevisionHistory/cc:entry">
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
        <h2>Contents</h2>
        <div class="toc">
          <!-- generate table of contents -->
          <xsl:apply-templates mode="toc" select="./cc:chapter" />
          <xsl:apply-templates mode="toc" select="./cc:appendix" />
        </div>
        <!-- process each toplevel chapter -->
        <xsl:apply-templates select="//cc:chapter" />
        <xsl:apply-templates select="//cc:appendix" />
      </body>
    </html>
  </xsl:template>
  <!-- Template for toc entries, for top 3 levels -->
  <xsl:template match="cc:chapter | cc:section | cc:class | cc:subsection" mode="toc">
    <xsl:param name="section-prefix" />
    <xsl:param name="section-num" select="position()" />
    <p xmlns="http://www.w3.org/1999/xhtml" class="toc2">
      <xsl:value-of select="$section-prefix" />
      <xsl:value-of select="$section-num" />
      <xsl:text>. </xsl:text>
      <a class="toc" href="#{@id}">
        <xsl:value-of select="@title" />
      </a>
    </p>
    <xsl:if test="./cc:chapter | ./cc:section | ./cc:subsection">
      <xsl:apply-templates mode="toc" select="./cc:chapter | ./cc:section | ./cc:subsection">
        <xsl:with-param name="section-prefix" select="concat($section-prefix,$section-num,'.')" />
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>
  <!-- Template for toc entries, for top 3 levels -->
  <xsl:template match="cc:appendix" mode="toc">
    <xsl:if test="$bool_appendicize or (@id!='optionalappendix' and @id!='selection-basedappendix' and @id!='objectiveappendix')">
      <xsl:variable name="appendix-num">
        <xsl:number format="A" count="cc:appendix"/>
      </xsl:variable>
      <p xmlns="http://www.w3.org/1999/xhtml" class="toc2">
        Appendix <xsl:value-of select="$appendix-num" /><xsl:text>: </xsl:text><a class="toc" href="#{@id}"><xsl:value-of select="@title" /></a></p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="cc:usecases">
    <dl>
      <xsl:for-each select="cc:usecase">
        <dt>
          [USE CASE <xsl:value-of select="position()" />] <xsl:value-of select="@title" /></dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:glossary">
    <table>
      <xsl:for-each select="cc:entry">
        <tr>
          <td>
            <xsl:apply-templates select="cc:term" />
          </td>
          <td>
            <xsl:apply-templates select="cc:description" />
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  <xsl:template match="cc:glossary/cc:entry/cc:term/cc:abbr">
      <span id="abbr_{text()}"><xsl:value-of select="@title" /> (<abbr><xsl:value-of select="text()" /></abbr>)</span>
  </xsl:template>
  <xsl:template match="cc:abbr[contains(concat('|', translate(@class, ' ', '|'), '|'), '|expanded|')]">
      <xsl:value-of select="@title" /> (<xsl:copy><xsl:apply-templates select="@*|node()" /></xsl:copy>)
  </xsl:template>

  <xsl:template match="cc:bibliography">
    <table>
      <tr class="header">
        <th>Identifier</th>
        <th>Title</th>
      </tr>
      <xsl:for-each select="cc:entry">
        <tr>
          <td>
            <xsl:element name="span">
              <xsl:attribute name="id">
                <xsl:value-of select="@id" />
              </xsl:attribute>
              [<xsl:value-of select="cc:tag" />]
            </xsl:element>
          </td>
          <td>
            <xsl:apply-templates select="cc:description" />
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="cc:acronyms">
    <table>
      <tr class="header">
        <th>Acronym</th>
        <th>Meaning</th>
      </tr>
      <xsl:for-each select="cc:entry">
        <tr>
          <td>
            <xsl:apply-templates select="cc:term" />
          </td>
          <td>
            <xsl:apply-templates select="cc:description" />
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="cc:ReferenceTable">
        PP-Title:<![CDATA[&]]><xsl:value-of select="cc:PPTitle" />
        PP-Version:<![CDATA[&]]><xsl:value-of select="cc:PPVersion" />
        PP-Author:<![CDATA[&]]><xsl:value-of select="cc:PPAuthor" />
        PP-Puplication Date:<![CDATA[&]]><xsl:value-of select="cc:PPPubDate" />   
        Certification-ID:<![CDATA[&]]><xsl:value-of select="cc:PPCertificationID" />
        CC-Version:<![CDATA[&]]><xsl:value-of select="cc:CCVersion" />
        Keywords:<![CDATA[&]]><xsl:value-of select="cc:Keywords" /><xsl:for-each select="cc:entry"><xsl:value-of select="cc:name" />:<![CDATA[&]]><xsl:value-of select="cc:description" /></xsl:for-each></xsl:template>
  <xsl:template match="cc:assumptions">
    <dl>
      <xsl:for-each select="cc:assumption">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <xsl:apply-templates select="cc:appnote" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:cclaims">
    <dl>
      <xsl:for-each select="cc:cclaim">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <xsl:apply-templates select="cc:appnote" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:threats">
    <dl>
      <xsl:for-each select="cc:threat">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <xsl:apply-templates select="cc:appnote" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:OSPs">
    <dl>
      <xsl:for-each select="cc:OSP">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <xsl:apply-templates select="cc:appnote" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:SOs">
    <dl>
      <xsl:for-each select="cc:SO">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <p />
	  Addressed by: 
	  <span class="SOlist"> 
	    <xsl:for-each select="cc:component-refer">
	      <xsl:element name="a"> <!-- Add a link to the actual section -->
		<xsl:attribute name="href">
		  <xsl:text>#</xsl:text>
		  <xsl:value-of select="translate(@ref,$lower,$upper)" />
		</xsl:attribute>
		<xsl:value-of select="translate(@ref,$lower,$upper)" />
	      </xsl:element>
	      <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if> <!-- If it's not the last, put a comma-->
	    </xsl:for-each> 
	  </span>
	  <xsl:apply-templates select="cc:appnote" /></dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:SOEs">
    <dl>
      <xsl:for-each select="cc:SOE">
        <dt>
          <xsl:value-of select="@id" />
        </dt>
        <dd>
          <xsl:apply-templates select="cc:description" />
          <xsl:apply-templates select="cc:appnote" />
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>
  <xsl:template match="cc:InsertSPDCorrespondence">
    <table>
      <tr class="header">
        <td>Threat, Assumption, or OSP</td>
        <td>Security Objectives</td>
      </tr>
      <xsl:for-each select="(//cc:threat | //cc:OSP | //cc:assumption)">
        <tr>
          <td>
            <xsl:value-of select="@id" />
          </td>
          <td>
            <xsl:for-each select="cc:objective-refer">
              <xsl:value-of select="@ref" />
              <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="cc:InsertRefMapping">
    <table>
      <tr class="header">
        <td>SFR ID</td>
        <td>NIST SP 800-53 Controls</td>
      </tr>
      <xsl:for-each select="(//cc:f-element)">
        <tr>
          <td>
			<xsl:value-of select="translate(@id,$lower,$upper)" />
          </td>
          <td>
              <xsl:if test="not(cc:refs/cc:ref)">
                <xsl:text>None</xsl:text>
              </xsl:if>
            <xsl:for-each select="cc:refs/cc:ref">
              <p/><a href="http://common-criteria.rhcloud.com/references/output/nist800-53controls.html#{@sect}"><xsl:value-of select="@sect" /></a>
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
    
    <xsl:template match="cc:f-component | cc:a-component">
        <!-- If we're not appendicizing or status is normal. Include-->
        <xsl:if test="not($bool_appendicize) or string-length(@status)=0">
            <xsl:variable name="family" select="substring(@id,1,7)" />
            <xsl:variable name="component" select="substring(@id,1,9)" />
            <xsl:variable name="SFRID" select="@id" />
            <!-- Make an anchor here -->
            <xsl:element name="div">
                <xsl:attribute name="class">comp</xsl:attribute>
                <xsl:attribute name="id"><xsl:value-of select="translate(@id, $lower, $upper)" /></xsl:attribute>
                <h4>
                    <xsl:value-of select="concat(translate(@id, $lower, $upper), ' ')" />
                    <xsl:value-of select="@name" />
                </h4>
                <xsl:apply-templates />
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="cc:f-element | cc:a-element">
        <!-- If we're not appendicizing or status is normal. Include-->
        <xsl:if test="not($bool_appendicize) or string-length(@status)=0">
            <xsl:variable name="reqid" select="translate(@id, $lower, $upper)" />
            <xsl:element name="div">
                <xsl:attribute name="class">req <xsl:value-of select="@status"/></xsl:attribute>
                <div class="reqid" id="{$reqid}">
                    <a href="#{$reqid}" class="abbr"><xsl:value-of select="$reqid" /></a>
                </div>
                <div class="reqdesc">
                    <xsl:apply-templates />
                </div>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="cc:title">
        <xsl:apply-templates />
        <xsl:if test="not($bool_appendicize)">
            <xsl:choose>
                <xsl:when test="../@status='objective'">
                    <div class="statustag">
                        <p/><i><b>This is currently an objective requirement.
                            <xsl:if test="../@targetdate">It is targeted for <xsl:value-of select="../@targetdate"/>.</xsl:if></b></i>
                    </div>
                    
                </xsl:when>
                <xsl:when test="../@status='optional'">
                    <div class="statustag">
                        <p/><i><b>This is an optional requirement.  It may be required by Extended Packages of this Protection Profile.</b></i>
                    </div>
                </xsl:when>
                <xsl:when test="../@status='sel-based'">
                    <div class="statustag">
                        <b><i>This is a selection-based requirement.
                            Its inclusion depends upon selection in 
                            <xsl:for-each select="../cc:selection-depends">
                                <xsl:value-of select="translate(@req, $lower, $upper)" />
                                <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
                            </xsl:for-each>.
                        </i></b>
                    </div>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
  <xsl:template match="cc:aactivity">
    <xsl:variable name="aactID" select="concat('aactID-', generate-id())" />
    <div class="aact">
      <a href="#hide-{$aactID}" class="hide" id="hide-{$aactID}">
        <span> Assurance Activity </span>
        <img style="vertical-align:middle" id="link-{$aactID}" src="images/collapsed.png" height="15" width="15" />
      </a>
      <a href="#show-{$aactID}" class="show" id="show-{$aactID}">
        <span> Assurance Activity </span>
        <img style="vertical-align:middle" id="link-{$aactID}" src="images/expanded.png" height="15" width="15" />
      </a>
      <div class="collapsed"></div>
      <div class="expanded">
        <i>
          <xsl:apply-templates />
        </i>
      </div>
    </div>
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

    <xsl:template match="cc:appendix[@id='optionalappendix']">
        <xsl:if test="$bool_appendicize">
            <xsl:variable name="appendix-num">
                <xsl:number format="A" count="cc:appendix"/>.</xsl:variable>
            <h1 id="{@id}">
                <xsl:value-of select="concat($appendix-num, ' ')" />
                <xsl:value-of select="@title" />
            </h1>
            <xsl:apply-templates/>
            <xsl:for-each select="//cc:f-element[@status='optional']">
                <xsl:variable name="reqid" select="translate(@id, $lower, $upper)" />
                <xsl:element name="div">
                    <xsl:attribute name="class">req <xsl:value-of select="@status"/></xsl:attribute>
                    <div class="reqid" id="{$reqid}">
                        <a href="#{$reqid}" class="abbr"><xsl:value-of select="$reqid" /></a>
                    </div>
                    <div class="reqdesc">
                        <xsl:apply-templates />
                    </div>
                </xsl:element>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="cc:appendix[@id='selection-basedappendix']">
        <xsl:if test="$bool_appendicize">
            <xsl:variable name="appendix-num">
                <xsl:number format="A" />.</xsl:variable>
            <h1 id="{@id}">
                <xsl:value-of select="concat($appendix-num, ' ')" />
                <xsl:value-of select="@title" />
            </h1>
            <xsl:apply-templates/>
            <xsl:for-each select="//cc:f-element[@status='sel-based']">
                <xsl:variable name="reqid" select="translate(@id, $lower, $upper)" />
                <xsl:element name="div">
                    <xsl:attribute name="class">req <xsl:value-of select="@status"/></xsl:attribute>
                    <div class="reqid" id="{$reqid}">
                        <a href="#{$reqid}" class="abbr"><xsl:value-of select="$reqid" /></a>
                    </div>
                    <div class="reqdesc">
                        <xsl:apply-templates />
                    </div>
                </xsl:element>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="cc:appendix[@id='objectiveappendix']">
        <xsl:if test="$bool_appendicize">
            <xsl:variable name="appendix-num">
                <xsl:number format="A" />.</xsl:variable>
            <h1 id="{@id}">
                <xsl:value-of select="concat($appendix-num, ' ')" />
                <xsl:value-of select="@title" />
            </h1>
            <xsl:apply-templates/>
            <xsl:for-each select="//cc:f-element[@status='objective']">
                <xsl:variable name="reqid" select="translate(@id, $lower, $upper)" />
                <xsl:element name="div">
                    <xsl:attribute name="class">req <xsl:value-of select="@status"/></xsl:attribute>
                    <div class="reqid" id="{$reqid}">
                        <a href="#{$reqid}" class="abbr"><xsl:value-of select="$reqid" /></a>
                    </div>
                    <div class="reqdesc">
                        <xsl:apply-templates />
                    </div>
                </xsl:element>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="cc:appendix">
        <xsl:variable name="appendix-num">
            <xsl:number format="A" />.</xsl:variable>
        <h1 id="{@id}">
            <xsl:value-of select="concat($appendix-num, ' ')" />
            <xsl:value-of select="@title" />
        </h1>
        <xsl:apply-templates>
            <xsl:with-param name="section-prefix" select="$appendix-num" />
        </xsl:apply-templates>
    </xsl:template>
    
  <xsl:template match="cc:chapter">
    <xsl:variable name="chapter-num" select="concat(position(), '.')" />
    <h1 id="{@id}">
      <xsl:value-of select="concat($chapter-num, ' ')" />
      <xsl:value-of select="@title" />
    </h1>
    <xsl:apply-templates>
      <xsl:with-param name="section-prefix" select="$chapter-num" />
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="cc:section">
    <xsl:param name="section-prefix" />
    <xsl:variable name="section-num">
      <xsl:number />
    </xsl:variable>
    <h2 id="{@id}">
      <xsl:value-of select="$section-prefix" />
      <xsl:value-of select="concat($section-num,' ')" />
      <xsl:value-of select="@title" />
    </h2>
    <xsl:apply-templates>
      <xsl:with-param name="subsection-prefix" select="concat($section-prefix, $section-num, '.')" />
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="cc:subsection">
    <xsl:param name="subsection-prefix" />
    <xsl:variable name="subsection-num">
      <xsl:number />
    </xsl:variable>
    <h3 id="{@id}">
      <xsl:value-of select="$subsection-prefix" />
      <xsl:value-of select="concat($subsection-num, ' ')" />
      <xsl:value-of select="@title" />
    </h3>
    <xsl:apply-templates>
      <xsl:with-param name="subsubsection-prefix" select="concat($subsection-prefix, $subsection-num, '.')" />
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="cc:subsubsection">
    <h4 id="{@id}">
      <xsl:value-of select="@title" />
    </h4>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="cc:figure">
    <div class="figure">
      <img>
        <xsl:attribute name="id">
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:attribute name="src">
          <xsl:value-of select="@entity" />
        </xsl:attribute>
        <xsl:attribute name="width">
          <xsl:value-of select="@width" />
        </xsl:attribute>
        <xsl:attribute name="height">
          <xsl:value-of select="@height" />
        </xsl:attribute>
      </img>
      <p />
      <b>
        <xsl:value-of select="@title" />
      </b>
    </div>
  </xsl:template>

  <!-- templates for creating references -->
  <!-- Assumes element with matching @id has a @title. -->
  <xsl:template match="cc:xref">
    <xsl:variable name="linkend" select="@linkend" />
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$linkend" />
      </xsl:attribute>
      <xsl:value-of select="//*[@id=$linkend]/@title" />
    </xsl:element>
  </xsl:template>
    
    <xsl:template match="cc:secref">
        <xsl:variable name="linkend" select="@linkend" />
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="$linkend" />
            </xsl:attribute>
            Section 
            <xsl:apply-templates select="//cc:chapter" mode="secreflookup"><xsl:with-param name="linkend" select="$linkend" /></xsl:apply-templates></xsl:element>
    </xsl:template>
    <xsl:template match="cc:appendref">
        <xsl:variable name="linkend" select="@linkend" />
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="$linkend" />
            </xsl:attribute>
            Appendix 
            <xsl:apply-templates select="//cc:appendix" mode="secreflookup"><xsl:with-param name="linkend" select="$linkend" /></xsl:apply-templates></xsl:element>
    </xsl:template>
    
    <xsl:template match="cc:appendix" mode="secreflookup">
        <xsl:param name="linkend" />
        <xsl:param name="prefix" />
        <xsl:variable name="pos">
            <xsl:number format="A"/>
        </xsl:variable>
        <xsl:if test="@id=$linkend">
            <xsl:value-of select="concat($prefix,$pos)" />
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="cc:chapter | cc:section | cc:subsection" mode="secreflookup">
        <xsl:param name="linkend" />
        <xsl:param name="prefix" />
        <xsl:variable name="pos" select="position()" />
        <xsl:if test="@id=$linkend">
            <xsl:value-of select="concat($prefix,$pos)" />
        </xsl:if>
        <xsl:if test="./cc:chapter | ./cc:section | ./cc:subsection">
            <xsl:apply-templates mode="secreflookup" select="./cc:chapter | ./cc:section | ./cc:subsection">
                <xsl:with-param name="linkend" select="$linkend" />
                <xsl:with-param name="prefix" select="concat($prefix,$pos,'.')" />
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cc:cite">
        <xsl:variable name="linkend" select="@linkend" />
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="$linkend" />
            </xsl:attribute>
            <xsl:text>[</xsl:text>
            <xsl:value-of select="//cc:bibliography/cc:entry[@id=$linkend]/cc:tag" />
            <xsl:text>]</xsl:text>
        </xsl:element>
    </xsl:template>
    
  <xsl:template match="cc:util">
    <span class="util">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="cc:path">
    <span class="path">
      <xsl:apply-templates/>
    </span>
  </xsl:template>


</xsl:stylesheet>
