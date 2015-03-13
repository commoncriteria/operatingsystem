<?xml version="1.0" encoding="utf-8"?>
<!-- 
    Stylesheet for Protection Profile Schema  
    Based on original work by Dennis Orth
    Subsequent modifications in support of US NIAP
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cc="http://common-criteria.rhcloud.com/ns/cc" xmlns="http://www.w3.org/1999/xhtml" 
		xmlns:fn="http://www.w3.org/2005/xpath-functions" version="1.0">

  <!-- release variable, overridden to "final" for release versions -->
  <xsl:param name="release" select="'draft'"/>


  <xsl:param name="appendicize" select="''"/>


  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  

  <!-- Put all common templates into ppcommons.xsl -->
  <!-- They can be redefined/overridden  -->
  <xsl:include href="ppcommons.xsl"/>


  <xsl:template match="/cc:PP">
    <xsl:apply-templates select="//cc:MUSTFIX" />

    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <script type="text/javascript">
          <!-- Function to expand and contract a given div -->
        	function toggle(divID, imgID) {
        		var item = document.getElementById(divID);
        		var img = document.getElementById(imgID);
        		if (item) {
        			item.className = (item.className=='aacthidden') ? 'aact':'aacthidden';
        		}
        		if (img) {
        			var currimage = img.src.substring(img.src.lastIndexOf('/')+1);
        			img.src=(currimage=='collapsed.png')?'images/expanded.png':'images/collapsed.png';
        			}
        	}

          <!-- Called on page load to parse URL parameters and perform actions on them. -->
         	function init(){
                if(getQueryVariable("expand") == "on"){
                  expand();
                }
        	}

          <!-- Pass a URL variable to this function and it will return it's value -->
          function getQueryVariable(variable)
          {
                 var query = window.location.search.substring(1);
                 var vars = query.split("&amp;");
                 for (var i=0;i&lt;vars.length;i++) {
                         var pair = vars[i].split("=");
                         if(pair[0] == variable){return pair[1];}
                 }
                 return(false);
          }

          <!-- Expands all assurance activities -->
          function expand(){  
              var divID = "";
              var imgID = "link-";
              var hidden_elements = document.getElementsByClassName('aacthidden');
              for (var i = hidden_elements.length - 1; i >= 0; --i) {
                divID = hidden_elements[i].id;
                imgID += divID;
                toggle(divID,imgID);
                imgID = "link-";
              }    
          }
        </script>
        <style type="text/css">
      /*       { background-color: #FFFFFF; } */
      body { margin-left: 8%; margin-right: 8%; foreground: black; }
      h1   { text-align: left; font-size: 200%;  margin-top: 2em; margin-bottom: 2em;
             font-family: verdana, arial, helvetica, sans-serif;
             margin-bottom: 1.0em; 
           }
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
      a.linkref { font-family:   verdana, arial, helvetica, sans-serif; font-size: 90%; }
      
      *.simpleText   { margin-left: 10%; }
      *.propertyText { margin-left: 10%; margin-top: 0.2em; margin-bottom: 0.2em }
      *.toc      { background: #FFFFFF; }
      *.toc2         { background: #FFFFFF; }
      div.comp        { margin-left: 8%; margin-top: 1em; margin-bottom: 1em; }
      div.appnote    { margin-left: 0%; margin-top: 1em; }
      div.aact       { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; 
						padding: 1em;
						border:2px solid  #888888; border-radius:3px; 
						display: block; 
      }
      .comment-aa { background-color: green; color: white; };
      div.subaact       { margin-left: 0%; margin-top: 1em;  }
      div.aacthidden    { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }    
      div.optional-appendicies { display: none; }

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
      div.expandstyle  { display:table-cell; vertical-align:middle; padding-top:10px }
      span.expandstyle  { vertical-align:middle;  color:black; text-decoration: none; font-size: 100%; font-weight: bold; /*font-family: verdana, arial, helvetica, sans-serif; */ }
      .expandstyle a         { color: black; text-decoration: none;  }
      .expandstyle a:link    { color: black; text-decoration: none;  }
      .expandstyle a:visited { color: black; text-decoration: none;  }
      .expandstyle a:hover   { color: black; text-decoration: none;  }
      .expandstyle a:active  { color: black; text-decoration: none;  } 
      
      @media screen {
        *.reqid { float:left; font-size: 90%; 
                  font-family:   verdana, arial, helvetica, sans-serif; margin-right:1em;}
        *.req { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }
        *.reqdesc { margin-left: 20%; }
          div.aacthidden{ display: none; }
        div.statustag {box-shadow: 4px 4px 3px #888888; }
        div.aact      {box-shadow: 4px 4px 3px #888888; }
      }

      @media print {
          *.reqid   { font-size: 90%; font-family: verdana, arial,
                helvetica,
                sans-serif; }
           *.req    { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }
           *.reqdesc  { margin-left: 20%; }
           div.aacthidden{
                   padding: 1em;
                   border:2px solid  #888888; border-radius:3px;
                   display: block;
           }
       }
      
      
  </style>
      </head>
      <body onLoad="init()">
        <h1 class="title">
          <xsl:value-of select="//cc:ReferenceTable/cc:PPTitle" />
        </h1>

	<noscript>
	  <h1 style="text-align:center; border-style: dashed; border-width: medium; border-color: red;">This page is best viewed with JavaScript enabled!</h1>
	</noscript>
        <div class="center">
          <xsl:choose>
            <xsl:when test="$release='final'"><img src="images/niaplogo.png" /></xsl:when>
            <xsl:when test="$release='draft'"><img src="images/niaplogodraft.png" /></xsl:when>
          </xsl:choose>
          <br/>
          <p/>Version: <xsl:value-of select="//cc:ReferenceTable/cc:PPVersion" />
		  <p/><xsl:value-of select="//cc:ReferenceTable/cc:PPPubDate" />
		  <p/><b><xsl:value-of select="//cc:PPAuthor" /></b></div>
        <h2 style="page-break-before:always;">Revision History</h2>
        <table>
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
  
  <!-- For the table of contents-->
  <xsl:template match="cc:appendix" mode="toc">
    <xsl:if test="$appendicize='on' or (@id!='optional' and @id!='sel-based' and @id!='objective')">
      <xsl:variable name="appendix-num">
      <xsl:choose>
        <xsl:when test="$appendicize='on'">
		  <xsl:number format="A" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:number format="A" count="cc:appendix[@id!='optional' and @id!='objective' and @id!='sel-based']"/>
        </xsl:otherwise>
      </xsl:choose>
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
        PP-Publication Date:<![CDATA[&]]><xsl:value-of select="cc:PPPubDate" />   
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

  <xsl:template match="cc:InsertAppendixExplainer">
    <xsl:if test="$appendicize='on'">
	  Unconditional requirements are found in the main body of the document, while
      appendices contain the selection-based, optional, and objective requirements.
    </xsl:if>
    <xsl:if test="$appendicize!='on'">
      The type of each requirement is identified inline with the text.
    </xsl:if>
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
        <td>Rationale</td>
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
          <td>
            <xsl:for-each select="cc:objective-refer">
              <xsl:apply-templates select="cc:rationale" />
              <xsl:if test="position() != last()"><p/></xsl:if>
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


  <!-- Used to match regular ?-components -->
  <xsl:template match="cc:f-component | cc:a-component">
    <xsl:variable name="sel">
      <xsl:if test="$appendicize!='on'">
	<xsl:value-of select="'__,_objective_, _optional_, _sel-based_'"/>
      </xsl:if>
      <xsl:if test="$appendicize='on'">
	<xsl:value-of select="'__'"/>
      </xsl:if>
    </xsl:variable>
    <xsl:call-template name="component-template">
      <xsl:with-param name="selected-statuses" select="$sel"/>
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="component-template">
    <xsl:param name="selected-statuses"/>
    <!-- If we're not appendicizing or status is normal. Include-->
    <xsl:if test="count(./*[contains($selected-statuses, concat('_', concat(@status, '_')))])>0">
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

	<xsl:for-each select="cc:f-element | cc:a-element">
	    <xsl:call-template name="element-template">
		<xsl:with-param name="selected-statuses" select="$selected-statuses"/>
   	    </xsl:call-template>
	</xsl:for-each>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- Prints out only those templates whose status is inside selected-statuses-->
  <xsl:template name="element-template">
    <xsl:param name="selected-statuses"/>
<!-- QQQ      Haystack: <xsl:value-of select="$selected-statuses"/> -->
<!-- QQQ      Needle: <xsl:value-of select="concat('_', concat(@status, '_'))"/> -->
    <xsl:if test="contains($selected-statuses, concat('_', concat(@status, '_')))">
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

    <xsl:if test="../@status='objective'">
	<xsl:if test="$appendicize!='on'">
	  <div class="statustag">
          <p/><i><b> This is an objective requirement.
	<xsl:if test="../@targetdate">It is scheduled to be mandatory for applications entering evaluation after <xsl:value-of select="../@targetdate"/> .</xsl:if></b></i>
	  </div>
	</xsl:if>
	<xsl:if test="$appendicize='on' and ../@targetdate">
	  <div class="statustag">
          <p/><i><b> This requirement is scheduled to be mandatory for applications entering evaluations after <xsl:value-of select="../@targetdate"/>.</b></i>
	  </div>
	</xsl:if>
    </xsl:if>

    <xsl:if test="../@status='sel-based'">
      <div class="statustag">
        <b><i>

	<xsl:if test="$appendicize!='on'">
	  This is a selection-based requirement.
	  Its inclusion depends upon selection in 
	</xsl:if>
	<xsl:if test="$appendicize='on'">
	  This requirement depends upon selection in
	</xsl:if>

	<xsl:for-each select="../cc:selection-depends">
          <xsl:variable name="reqid" select="translate(@req, $lower, $upper)" />
          <a href="#{$reqid}" class="abbr"><xsl:value-of select="$reqid" /></a>
	  <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
	  </xsl:for-each>.
	</i></b>
      </div>
    </xsl:if>
    


    <xsl:if test="$appendicize!='on'">
      <xsl:if test="../@status='optional'">
	<div class="statustag">
          <p/><i><b>This is an optional requirement.  It may be required by Extended Packages of this Protection Profile.</b></i>
	</div>
      </xsl:if>

    </xsl:if>
  </xsl:template>

  <xsl:template match="cc:aactivity">
    <xsl:variable name="aactID" select="concat('aactID-', generate-id())" />
    <div class="expandstyle">
      <a href="javascript:toggle('{$aactID}', 'link-{$aactID}');">
        <span class="expandstyle"> Assurance Activity </span>
        <img style="vertical-align:middle" id="link-{$aactID}" src="images/collapsed.png" height="15" width="15" />
      </a>
    </div>
    <div class="aacthidden" id="{$aactID}">
      <i>
        <xsl:apply-templates />
      </i>
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

  <xsl:template match="cc:indent">
    <div class="indent" style="margin-left:2em">
      <xsl:apply-templates />
    </div>
  </xsl:template>
  
  
  <xsl:template match="cc:appendix">
    <xsl:if test="$appendicize='on' or (@id!='optional' and @id!='sel-based' and @id!='objective')">
      <xsl:variable name="appendix-num">
	<xsl:choose>
          <xsl:when test="$appendicize='on'">
		    <xsl:number format="A." />
		  </xsl:when>
          <xsl:otherwise>
	        <!-- Don't count ones with these special IDs -->
            <xsl:number format="A." count="cc:appendix[@id!='optional' and @id!='objective' and @id!='sel-based']"/>
          </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>
      <h1 id="{@id}">
	<xsl:value-of select="concat($appendix-num, ' ')" />
	<xsl:value-of select="@title" />
      </h1>
      <!-- Convert the words -->
      <xsl:apply-templates>
	<xsl:with-param name="section-prefix" select="$appendix-num" />
      </xsl:apply-templates>

      <!-- If we need to steal templates from the rest of the document -->
      <xsl:call-template name='requirement-stealer'>
	<xsl:with-param name="selected-status" select="@id"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="requirement-stealer">
    <xsl:param name="selected-status"/>
    <!-- Select all f-componenets which have an f-element with a selected-status-->
    
    <xsl:for-each select="//cc:f-component[cc:f-element/@status=$selected-status]">
	<xsl:call-template name="component-template">
	  <xsl:with-param name="selected-statuses" select="concat('_', concat($selected-status,'_'))"/>
	</xsl:call-template>
    </xsl:for-each>
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

  <xsl:template match="cc:linkref">
    <xsl:variable name="linkend" select="@linkend" />
    <a class="linkref" href="#{$linkend}"><xsl:value-of select="$linkend" /></a>
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


  <xsl:template match="cc:appref">
    <xsl:variable name="linkend" select="@linkend" />
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$linkend" />
      </xsl:attribute>
      Appendix 
      <xsl:apply-templates select="//cc:appendix" mode="secreflookup"><xsl:with-param name="linkend" select="$linkend" /></xsl:apply-templates>
	  </xsl:element>
  </xsl:template>

  <xsl:template match="cc:chapter | cc:section | cc:subsection | cc:appendix" mode="secreflookup">
    <xsl:param name="linkend" />
    <xsl:param name="prefix" />
	<!-- make the identifier a letter or number as appropriate for appendix or chapter/section -->
    <xsl:variable name="pos"> 
      <xsl:choose>
        <xsl:when test="name()='appendix'">
          <xsl:choose>
          <xsl:when test="$appendicize='on'">
		    <xsl:number format="A" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:number format="A" count="cc:appendix[@id!='optional' and @id!='objective' and @id!='sel-based']"/>
          </xsl:otherwise>
          </xsl:choose>
        </xsl:when>	
        <xsl:otherwise>	
		  <xsl:number />
        </xsl:otherwise>	
      </xsl:choose>	
    </xsl:variable> 
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
