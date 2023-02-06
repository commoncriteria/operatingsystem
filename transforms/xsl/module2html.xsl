<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cc="https://niap-ccevs.org/cc/v1"
  xmlns:sec="https://niap-ccevs.org/cc/v1/section"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:htm="http://www.w3.org/1999/xhtml"
  version="1.0">

  <!-- ################################################## -->
  <!--                   Imports                          -->
  <!-- ################################################## -->
  <xsl:import href="pp2html.xsl"/>
  <xsl:import href="module-commons.xsl"/>


  <xsl:output method="xml" encoding="UTF-8"/>

  <!-- Directory where the base PPs currently reside (with apthe names 0.xml, 1.xml,...)-->
  <xsl:param name="basesdir"/>

  <!-- Value on whether this is the formal release build -->
  <xsl:param name="release" select="final"/>

  <!-- ################################################## -->
  <!--                   Templates Section                -->
  <!-- ################################################## -->
  <!-- ############### -->
  <!--   Top Module    -->
  <!-- ############### -->
  <xsl:template match="cc:Module">
    <xsl:apply-templates select="//*[@title='Introduction']|sec:Introduction"/>
    <xsl:apply-templates select="//*[@title='Conformance Claims']|sec:Conformance_Claims"/>
    <xsl:apply-templates select="//*[@title='Security Problem Description']|sec:Security_Problem_Description"/>
    <xsl:apply-templates select="//*[@title='Security Objectives']|sec:Security_Objectives"/>
    <xsl:apply-templates select="//*[@title='Security Requirements']|sec:Security_Requirements"/>
    <xsl:call-template name="mod-obj-req-map"/>
    <!-- <xsl:call-template name="sars"/> -->
    <xsl:call-template name="mod-sars"/>
    <xsl:call-template name="consistency-rationale"/>
    <xsl:call-template name="opt-sfrs"/>
    <xsl:call-template name="sel-sfrs"/>
    <xsl:call-template name="ext-comp-defs"/>
    <xsl:apply-templates select="//cc:appendix"/>
    <xsl:call-template name="acronyms"/>
    <xsl:call-template name="bibliography"/>
  </xsl:template>

  <xsl:template name="sars">
      <xsl:call-template name="make_header">
	    <xsl:with-param name="title" select="'TOE Security Assurance Requirements'"/>
		<xsl:with-param name="id" select="'mod-sars'"/>
		<xsl:with-param name="level" select="2"/>
      </xsl:call-template>
      <xsl:choose><xsl:when test="//cc:a-component">FILL IN THIS BOILERPLATE TEXT</xsl:when>
	  <xsl:otherwise>
      
        This PP-Module does not define any SARs beyond those defined within the Base-PP<xsl:if test="count(//cc:base-pp)>1">s</xsl:if> to which it can
		claim conformance. It is important to note that a TOE that is evaluated against this PP-Module is
		inherently evaluated against the 
		<xsl:for-each select="//cc:base-pp">
		  <xsl:if test="(position()=last()) and (position()>1)"> and </xsl:if>
		  <xsl:apply-templates mode="short" select="."/>
		  <xsl:call-template name="commaifnotlast"/>
		</xsl:for-each>	
		as well. 
		<xsl:choose>
		  <xsl:when test="count(//cc:base-pp)=1">This PP includes</xsl:when>
		  <xsl:otherwise>These PPs include </xsl:otherwise></xsl:choose> a
		number of EAs associated with both Security Functional Requirements (SFRs) and SARs. Additionally, this
		PP-Module includes a number of SFR-based EAs that similarly refine the SARs of the Base-PP<xsl:if test="count(//cc:base-pp)>1">s</xsl:if>.
		The
		evaluation laboratory will evaluate the TOE against the chosen Base-PP and supplement that evaluation
		with the necessary SFRs that are taken from this PP-Module.
	  </xsl:otherwise></xsl:choose>
  </xsl:template>
  <!-- ############### -->
  <!--   Overwrites template from pp2html.xsl -->
  <!-- ############### -->
  <xsl:template match="cc:threat|cc:assumption|cc:OSP" mode="get-representation">
    <xsl:value-of select="@name"/>
    <xsl:if test="cc:from"> (from <xsl:value-of select="cc:from/@base"/>)</xsl:if>
  </xsl:template>


  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="mod-obj-req-map">
    <xsl:if test="//cc:SO/cc:addressed-by">
      <h2 id="obj-req-map" class="indexable" data-level="2">TOE Security Functional Requirements Rationale</h2>
      <xsl:call-template name="obj-req-map"/>
    </xsl:if>
  </xsl:template> 

  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template match="/cc:Module//*[@title='Security Requirements']|/cc:Module//sec:Security_Requirements">
    <xsl:variable name="id"><xsl:choose>
      <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
      <xsl:when test="namespace-uri()='https://niap-ccevs.org/cc/v1/section'"><xsl:value-of select="local-name()"/></xsl:when>
      <xsl:otherwise>Security_Requirements</xsl:otherwise>
    </xsl:choose></xsl:variable>

    
    <h1 id="{$id}" class="indexable" data-level="1">Security Requirements</h1>
    <xsl:call-template name="secrectext"/>
    <xsl:apply-templates select="cc:base-pp"/>
    <xsl:call-template name="man-sfrs"/>
  </xsl:template>

  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="consistency-rationale">
    <h1 id="mod-conrat" class="indexable" data-level="1">Consistency Rationale</h1>

    <xsl:for-each select="//cc:base-pp">
      <xsl:variable name="base" select="."/>

      <h2 id="conrat-{@id}" class="indexable" data-level="2">
	<xsl:apply-templates select="." mode="expanded"/>
      </h2>

      <!-- #################### -->
      <h3 id="contoe-{@id}" class="indexable" data-level="3">
	Consistency of TOE Type
      </h3>
      <xsl:apply-templates select="./cc:con-toe"/>

      <!-- #################### -->
      <h3 id="consecprob-{@id}" class="indexable" data-level="3">
	Consistency of Security Problem Definition
      </h3>
<!--      The threats, assumptions, and OSPs defined by this PP-Module (see section 3.1) supplement those defined in the
      <xsl:apply-templates mode="short" select="."/> as follows: -->
      <xsl:apply-templates select="./cc:con-sec-prob"/>
      <table><tr><th>PP-Module Threat, Assumption, OSP</th><th>Consistency Rationale</th></tr>
      <xsl:for-each select="//cc:threat[cc:description]|//cc:assumption[cc:description]|//cc:OSP[cc:description]">
	<xsl:call-template name="consistency-row">
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="orig" select="."/>
	</xsl:call-template>
      </xsl:for-each>
      </table>

      <!-- #################### -->
      <h3 id="conobj-{@id}" class="indexable" data-level="3">
	Consistency of Objectives
      </h3>
      <p>
      <xsl:apply-templates select="./cc:con-obj"/>
      <xsl:if test="//cc:SO[cc:description]">
	  The objectives for the TOEs are consistent with the <xsl:apply-templates mode="short" select="."/> based on the following rationale:
      <table><tr><th>PP-Module TOE Objective</th><th>Consistency Rationale</th></tr>
      <xsl:for-each select="//cc:SO[cc:description]">
	<xsl:call-template name="consistency-row">
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="orig" select="."/>
	</xsl:call-template>
      </xsl:for-each>
      </table>
      </xsl:if>
      </p>

      <p>
      <xsl:apply-templates select="./cc:con-op-en"/>
      <xsl:if test="//cc:SOE">
	  The objectives for the TOE's OE are consistent with the <xsl:apply-templates mode="short" select="."/> based on the following rationale:
      <table><tr><th>PP-Module OE Objective</th><th>Consistency Rationale</th></tr>
      <xsl:for-each select="//cc:SOE">
	<xsl:call-template name="consistency-row">
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="orig" select="."/>
	</xsl:call-template>
      </xsl:for-each>
      </table>
      </xsl:if>
      </p>

      <h3 id="conreq-{@id}" class="indexable" data-level="3">
	Consistency of Requirements
      </h3>
      <xsl:apply-templates select="./cc:con-req"/>
      This PP-Module identifies several SFRs from the
      <xsl:apply-templates mode="short" select="."/> that are needed to support
      <xsl:apply-templates mode="get_product" select="/cc:Module"/> functionality.
      This is considered to be consistent because the functionality provided by the
      <xsl:apply-templates mode="short" select="."/> is being used for its intended purpose.
      <xsl:choose>
        <xsl:when test='$base//cc:modified-sfrs//cc:f-element'>
          The PP-Module also identifies a number of modified SFRs from the
          <xsl:apply-templates mode="short" select="."/>
          <xsl:if test='$base//cc:additional-sfrs//cc:f-element'>
            as well as new SFRs 
          </xsl:if>
          that are used entirely to provide functionality for
	  <xsl:apply-templates mode="get_product_plural" select="/cc:Module"/>.
        </xsl:when>
        <xsl:when test='$base//cc:additional-sfrs//cc:f-element'>
            The PP-Module identifies new SFRs that are used entirely to provide
            functionality for
 	    <xsl:apply-templates mode="get_product_plural" select="/cc:Module"/>.
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
          The rationale for why this does not conflict with the claims
      defined by the
      <xsl:apply-templates mode="short" select="."/> are as follows:
      <table>
	<tr><th>PP-Module Requirement</th><th>Consistency Rationale</th></tr>
	<tr> <th colspan="2"> Modified SFRs</th></tr>
	<xsl:call-template name="req-con-rat-sec">
	  <xsl:with-param name="f-comps" select="$base/cc:modified-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	  <xsl:with-param name="none-msg">
	    This PP-Module does not modify any requirements when the
	    <xsl:apply-templates mode="short" select="."/> is the base.
	  </xsl:with-param>
	</xsl:call-template>

  	<tr>
	    <th colspan="2"> Additional SFRs</th>
	  </tr>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="$base/cc:additional-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not add any requirements when the
	      <xsl:apply-templates mode="short" select="."/> is the base.
	    </xsl:with-param>
	  </xsl:call-template>

	<tr>
	  <th colspan="2"> Mandatory SFRs</th>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="//cc:man-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not define any Mandatory requirements.
	    </xsl:with-param>
	  </xsl:call-template>
	</tr>
	<tr>
	  <th colspan="2"> Optional SFRs</th>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="//cc:opt-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not define any Optional requirements.
	    </xsl:with-param>
	  </xsl:call-template>
	</tr>
	<tr>
	  <th colspan="2"> Objective SFRs</th>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="//cc:obj-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not define any Objective requirements.
	    </xsl:with-param>
	  </xsl:call-template>
	</tr>
	<tr>
	  <th colspan="2"> Implementation-based SFRs</th>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="//cc:impl-dep-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not define any Implementation-based requirements.
	    </xsl:with-param>
	  </xsl:call-template>
	</tr>
	<tr>
	  <th colspan="2"> Selection-based SFRs</th>
	  <xsl:call-template name="req-con-rat-sec">
	    <xsl:with-param name="f-comps" select="//cc:sel-sfrs//cc:f-component[not(@status='invisible')]"/>
	  <xsl:with-param name="id" select="$base/@id"/>
	    <xsl:with-param name="none-msg">
	      This PP-Module does not define any Selection-based requirements.
	    </xsl:with-param>
	  </xsl:call-template>
	</tr>


      </table>
    </xsl:for-each> <!-- End base iteration -->
  </xsl:template>

<!-- ############################################ -->
<!-- # Requirement Consistency Rational Section # -->
<!-- ############################################ -->
  <xsl:template name="req-con-rat-sec">
    <xsl:param name="f-comps"/>
    <xsl:param name="id"/>
    <xsl:param name="none-msg"/>
    
    <xsl:choose>
      <xsl:when test="$f-comps">
      	<xsl:for-each select="$f-comps"><tr>

          <td><xsl:apply-templates mode="getId" select="."/></td>
          <td> <xsl:choose><!--
            <xsl:when test="@iteration and //cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@cc-id and @iteration=current()/@iteration]">
              <xsl:apply-templates select="//cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@cc-id and @iteration=current()/@iteration]"/>
            </xsl:when>
            <xsl:when test="not(@iteration) and //cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@cc-id and not(@iteration)]">
<<<<<<< HEAD
              <xsl:apply-templates select="//cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@cc-id and not(@iteration)]"/>
-->
            <xsl:when test="//cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@id]">
              <xsl:apply-templates select="//cc:base-pp[@id=$id]//cc:con-mod[@ref=current()/@id]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="cc:consistency-rationale/node()">
                <xsl:with-param name="base" select="$id"/>
              </xsl:apply-templates>
            </xsl:otherwise>
            </xsl:choose></td>
         </tr></xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <tr><td colspan="2" style="text-align:center">
          <xsl:value-of select="$none-msg"/>
        </td></tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- ############################################ -->
  <!-- #            Base-pp Template              # -->
  <!-- ############################################ -->
  <xsl:template match="cc:base-pp">
    <h2 id="secreq-{@id}" class="indexable" data-level="2">
      <xsl:apply-templates mode="short" select="."/>
       Security Functional Requirements Direction
    </h2>
    <xsl:if test="not(cc:sec-func-req-dir)">
      In a PP-Configuration that includes the <xsl:apply-templates mode="short" select="."/>,
      the TOE is expected to rely on some of the security functions implemented by the
      <xsl:apply-templates mode="get_product" select="/"/>
      as a whole and evaluated against the  <xsl:apply-templates mode="short" select="."/>.
      The following sections describe any modifications that the ST author must make to the SFRs
      defined in the <xsl:apply-templates mode="short" select="."/> in addition to what is mandated by <a class="dynref" href="#man-sfrs">Section </a>.
    </xsl:if>
    <xsl:apply-templates select="cc:sec-func-req-dir"/>


    <h3 id="modsfr-{@id}" class="indexable" data-level="3"> Modified SFRs </h3>
    <xsl:choose><xsl:when test="cc:modified-sfrs//cc:f-component">
      The SFRs listed in this section are defined in the <xsl:apply-templates mode="short" select="."/> and relevant to the secure operation of the TOE.
    <xsl:apply-templates select="cc:modified-sfrs"/>
    </xsl:when>
    <xsl:otherwise>
      This PP-Module does not modify any SFRs defined by the <xsl:apply-templates mode="short" select="."/>.
    </xsl:otherwise>
    </xsl:choose>
    <!--
	 If we have only one base PP, we should hide this section (so says NIAP).
	 In that case there shouldn't be any additional-sfrs (but for some
	 reason we're allowing it).
    -->

    <xsl:if test="count(//cc:base-pp)>1 or cc:additional-sfrs//cc:f-component" >
    <h3 id="addsfr-{@id}" class="indexable" data-level="3"> Additional SFRs</h3>
    <xsl:choose><xsl:when test="cc:additional-sfrs//cc:f-component">
      This section defines additional SFRs that must be added to the TOE boundary in order to implement the functionality in any PP-Configuration where the <xsl:apply-templates mode="short" select="."/> is claimed as the Base-PP.
      <xsl:apply-templates select="cc:additional-sfrs"/>
    </xsl:when>
    <xsl:otherwise>
This PP-Module does not define any additional SFRs for any PP-Configuration where the <xsl:apply-templates mode="short" select="."/> is claimed as the Base-PP.
    </xsl:otherwise>
    </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template match="cc:con-sec-problem">
    <xsl:apply-templates/>
  </xsl:template>



  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="consistency-row">
    <xsl:param name="base"/>
    <xsl:param name="orig"/>
	<tr>
	  <td><xsl:value-of select="$orig/@name"/></td>
	  <!-- if the base section has a con-mod equal to the id -->
	  <td><xsl:choose>
	    <xsl:when test="$base/cc:con-mod[@ref=$orig/@name]">
	      <xsl:apply-templates select="$base/cc:con-mod[@ref=$orig/@name]"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <!-- Can only go one element deep here -->
	      <xsl:apply-templates select="cc:consistency-rationale/node()">
		<xsl:with-param name="base" select="$base/@id"/>
	      </xsl:apply-templates>
	    </xsl:otherwise>
	  </xsl:choose></td>
	</tr>
  </xsl:template>

  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="man-sfrs">
    <h2 id="man-sfrs" class="indexable" data-level="2">TOE Security Functional Requirements</h2>
    <xsl:choose>
      <xsl:when test="//cc:man-sfrs/cc:description">
         <xsl:apply-templates select="//cc:man-sfrs"/>
      </xsl:when>
      <xsl:when test="//cc:man-sfrs//cc:f-component">
	The following section describes the SFRs that must be satisfied by any TOE that claims conformance to this PP-Module.
	These SFRs must be claimed regardless of which PP-Configuration is used to define the TOE.
        <xsl:apply-templates select="//cc:man-sfrs"/>
      </xsl:when>
      <xsl:otherwise>
	This PP-Module does not define any mandatory SFRs.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="mod-sars">
	  <xsl:if test="//cc:mod-sars">		  
	    <h2 id="mod-sars" class="indexable" data-level="2">TOE Security Assurance Requirements</h2>
    	    <xsl:choose>
   	      <xsl:when test="//cc:mod-sars/cc:description">
        	<xsl:apply-templates select="//cc:mod-sars"/>
	      </xsl:when>
	      <xsl:when test="//cc:mod-sars//cc:a-component">
			The following section describes the SARs that must be satisfied by any TOE that claims conformance to this PP-Module.
			These SARs must be claimed regardless of which PP-Configuration is used to define the TOE.
        		<xsl:apply-templates select="//cc:mod-sars"/>
	      	</xsl:when>
	    	<xsl:otherwise>
			This PP-Module does not define any Security Assurance requirements. The SARs from the Base-PP must be satisfied.
	      </xsl:otherwise>
    	</xsl:choose>
	  </xsl:if>
  </xsl:template>


  <xsl:template match="cc:opt-sfrs|cc:obj-sfrs|cc:sel-sfrs|cc:impl-dep-sfrs" mode="app-sfr-sec">
    <xsl:variable name="level"
      select="document('boilerplates.xml')//cc:mod-appendix/*[local-name()=local-name(current())]/@level"/>
    <xsl:variable name="name"
      select="document('boilerplates.xml')//cc:mod-appendix/*[local-name()=local-name(current())]/@name"/>

   
    <xsl:element name="h{$level}">
      <xsl:attribute name="id"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:attribute name="class"><xsl:value-of select="'indexable'"/></xsl:attribute>
      <xsl:attribute name="data-level"><xsl:value-of select="$level"/></xsl:attribute>
      <xsl:value-of select="$name"/> Requirements
    </xsl:element>
    <xsl:if test="not(.//cc:f-component)">
     <p>This PP-Module does not define any 
       <xsl:value-of select="$name"/>       SFRs.</p>
    </xsl:if>
    <xsl:apply-templates>
       <xsl:with-param name="lmod" select="$level - 2"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="opt-sfrs">
    <h1 id="opt-sfrs" class="indexable" data-level="A">Optional SFRs</h1>
    <xsl:apply-templates select="//cc:opt-sfrs" mode="app-sfr-sec"/>
    <xsl:apply-templates select="//cc:obj-sfrs" mode="app-sfr-sec"/>
    <xsl:apply-templates select="//cc:impl-dep-sfrs" mode="app-sfr-sec"/>
  </xsl:template>
  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <xsl:template name="sel-sfrs">
    <xsl:apply-templates select="//cc:sel-sfrs" mode="app-sfr-sec"/> 
  </xsl:template>


  <xsl:template match="cc:appendix[@title='Use Case Templates' and not(@id)]">
    <xsl:call-template name="use-case-appendix"/>
  </xsl:template>

  <xsl:template match="cc:appendix[@title='Use Case Templates' and @id]">
    <xsl:call-template name="use-case-appendix"><xsl:with-param name="appid" select="@id"/></xsl:call-template>
  </xsl:template>

  <!-- ############### -->
  <!-- Handles replace elements     -->
  <!-- ############### -->

  <xsl:template match="cc:modified-sfrs//cc:replace[cc:suppress-text]"/>

  <xsl:template match="cc:modified-sfrs//cc:replace[not(cc:suppress-text)]">
    <xsl:choose>
      <xsl:when test="cc:depends[not(@*)]">
	When the TOE conforms to this PP-Module, this SFR is mandatory
      </xsl:when>
      <xsl:when test="cc:depends[@*]">
	When the TOE conforms to this PP-Module, the triggers for inclusion of this SFR have changed to the following:
	<xsl:call-template name="handle_thing_with_depends"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="cc:replace[not(ancestor::cc:modified-sfrs)]"/>


  
  <!-- ############### -->
  <!--      -->
  <!-- ############### -->
  <!-- 
  Handles activities. In the release version( for modules)
  activites go in the SD.
  -->





</xsl:stylesheet>
