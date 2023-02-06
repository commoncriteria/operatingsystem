<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cc="https://niap-ccevs.org/cc/v1"
  xmlns:sec="https://niap-ccevs.org/cc/v1/section"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:htm="http://www.w3.org/1999/xhtml"
  version="1.0">

  <xsl:variable name="doctype"><xsl:value-of select="local-name(/cc:*)"/></xsl:variable>
  <!-- Eat all unmatched sections for cc and hook -->
  <xsl:template match="cc:*|sec:*" mode="hook"/>

  <!-- Eat all individual ones that turn off boilerplating -->
  <xsl:template match="//cc:*[@boilerplate='no']" priority="1.0" mode="hook"/>

  <xsl:template match="/cc:*[@boilerplate='yes']//*[@title='Implicitly Satisfied Requirements']|/cc:*[@boilerplate='yes']//sec:Implicitly_Satisfied_Requirements" mode="hook">
	<p>This appendix lists requirements that should be considered satisfied by products
	successfully evaluated against this <xsl:call-template name="doctype-short"/>. These requirements are not featured
	explicitly as SFRs and should not be included in the ST. They are not included as 
	standalone SFRs because it would increase the time, cost, and complexity of evaluation.
	This approach is permitted by <a href="#bibCC">[CC]</a> Part 1, 8.2 Dependencies between components.</p>
	<p>This information benefits systems engineering activities which call for inclusion of particular
	security controls. Evaluation against the <xsl:call-template name="doctype-short"/> provides evidence that these controls are present 
	and have been evaluated.</p>
</xsl:template>

  
  <xsl:template mode="hook"
    match="/cc:*[@boilerplate='yes']//*[@title='Terms']|/cc:*//sec:Terms[not(@boilerplate='no') and not(@title)]"> 
    The following sections list Common Criteria and technology terms used in this document.
  </xsl:template>


  <xsl:template name="doctype-short" match="cc:doctype-short">
	<xsl:choose>
		<xsl:when test="$doctype='Package'">PP-Package</xsl:when>
                <xsl:when test="$doctype='Module'">PP-Module</xsl:when>
		<xsl:otherwise>PP</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="doctype-long"  match="cc:doctype-long">
	<xsl:choose>
		<xsl:when test="$doctype='Package'">Functional Package</xsl:when>
                <xsl:when test="$doctype='Module'">Protection Profile Module</xsl:when>
		<xsl:otherwise>Protection Profile</xsl:otherwise>
	</xsl:choose>
</xsl:template>
	
  <!-- ############## -->
  <xsl:template 
      match="/cc:PP[@boilerplate='yes']//*[@title='Conformance Claims' and not(@boilerplate='no')]|//sec:Conformance_Claims[not(@boilerplate='no')]"
		mode="hook">
    <dl>
        <dt>Conformance Statement</dt>
        <dd><xsl:choose><xsl:when test="//cc:Module">
          <p>This PP-Module inherits exact conformance as required from the specified
          Base-PP and as defined in the CC and CEM addenda for Exact Conformance, Selection-based
          SFRs, and Optional SFRs (dated May 2017).</p>
          <p>The following PPs and PP-Modules are allowed to be specified in a 
            PP-Configuration with this PP-Module. <ul>
            <xsl:for-each select="//cc:base-pp">
              <li><xsl:apply-templates select="." mode="make_xref"/></li>
            </xsl:for-each>
          </ul>
          </p>
          </xsl:when><xsl:otherwise>
	  <htm:p>
            An ST must claim exact conformance to this <xsl:call-template name="doctype-short"/>, 
            as defined in the CC and CEM addenda for Exact Conformance, Selection-based SFRs, and 
            Optional SFRs (dated May 2017).
	  </htm:p>
          <xsl:if test="/cc:PP//cc:module">
	    <htm:p>
              The following PP-Modules are allowed to be specified in a PP-Configuration with this PP.
              <htm:ul>
		<xsl:for-each select="/cc:PP//cc:module">
                  <htm:li><xsl:apply-templates select="." mode="make_xref"/></htm:li>
		</xsl:for-each>
              </htm:ul>
	  </htm:p>
            <!-- <dd>One or more of the following modules -->
            <!-- <xsl:choose> -->
            <!--   <xsl:when  test="//cc:modules/@required"> must </xsl:when> -->
            <!--   <xsl:otherwise>can </xsl:otherwise> -->
            <!-- </xsl:choose> -->
            <!-- be specified in a PP-Configuration with this PP. -->
            <!-- <ul> -->
            <!--   <xsl:for-each select="//cc:modules/cc:module"> -->
            <!--     <li><xsl:apply-templates select="." mode="make_xref"/></li> -->
            <!--   </xsl:for-each> -->
            <!-- </ul> -->
            <!-- </dd> -->
          </xsl:if>

        </xsl:otherwise></xsl:choose></dd>
        <dt>CC Conformance Claims</dt>
        <dd>This <xsl:call-template name="doctype-short"/> is conformant to Parts 2 (extended) and 3 (conformant) of Common Criteria <xsl:call-template name="verrev"/>.</dd>
        <dt>PP Claim </dt>
        <dd>This <xsl:call-template name="doctype-short"/> does not claim conformance to any Protection Profile. </dd>

        <dt>Package Claim</dt>
        <dd>This <xsl:call-template name="doctype-short"/><xsl:text> </xsl:text>
            <xsl:choose>
               <xsl:when test="count(//cc:include-pkg)='1'"> is  
                  <xsl:apply-templates select="//cc:include-pkg" mode="show"/></xsl:when>
               <xsl:when test="//cc:include-pkg">is  
                  <xsl:for-each select="//cc:include-pkg">
                      <xsl:if test="position()=last()"> and </xsl:if>
                      <xsl:apply-templates select="." mode="show"/><!--
                      --><xsl:if test="count(//cc:include-pkg)>2 and not(position()=last())">, </xsl:if><!--
		  --></xsl:for-each>
               </xsl:when>
               <xsl:otherwise> does not claim conformance to any packages</xsl:otherwise> 
            </xsl:choose>.</dd>
     </dl>
  </xsl:template>


  <!-- ############## -->
   <xsl:template  name="verrev">Version 3.1, Revision 5</xsl:template>

  <!-- ############## -->
  <xsl:template name="format-of-document">
    <section title="Format of this Document" id="docformat">
      <secref linkend="req"/> contains baseline requirements  which must be implemented in the product 
        and included in any Security Target (ST)
        that claims conformance to this <xsl:call-template name="doctype-long"/> (<xsl:call-template name="doctype-short"/>).
        There are three other types of requirements that can be included in an ST
        claiming conformance to this <xsl:call-template name="doctype-short"/>:
        <htm:ul>
          <htm:li>
            <appref linkend="optional"/> contains requirements that may optionally be included in the ST, 
            but inclusion is at the discretion of the ST author.
          </htm:li>
          <htm:li>
        <appref linkend="sel-based"/> contains requirements based on selections
        in the requirements in <secref linkend="req"/>: if certain selections are
        made, then the corresponding requirements in that appendix must be included.
        </htm:li>
        <htm:li>
        <appref linkend="objective"/> contains requirements that will
        be included in the baseline requirements in future versions of this <xsl:call-template name="doctype-long"/>. Earlier adoption by vendors is
        encouraged and may influence acquisition decisions.
        Otherwise, these are treated the same as Optional Requirements.
        </htm:li>
        </htm:ul>
  </section>
  </xsl:template>

   <xsl:template mode="hook" name="secrectext"
        match="/cc:PP[@boilerplate='yes']//*[@title='Security Requirements' and not(@boilerplate='no')]|/cc:PP//sec:Security_Requirements[not(@boilerplate='no')]"
       >
      This chapter describes the security requirements which have to be fulfilled by the product under evaluation.
     Those requirements comprise functional components from Part 2 and assurance components from Part 3 of 
       <xsl:call-template name="citeCC"/>.
       <xsl:apply-templates select="document('boilerplates.xml')//*[@title='Security Requirements']"/>
   </xsl:template>
   <!-- TODO: Review this -->
   <xsl:template match="/cc:Module//cc:*[@title='Security Requirements']|/cc:Package//sec:Security_Functional_Requirements|//cc:Package//cc:*[@title='Security Functional Requirements']" mode="hook">
      This chapter describes the security requirements which have to be fulfilled by the product under evaluation.
      Those requirements comprise functional components from Part 2 of <xsl:call-template name="citeCC"/>.
 
       <xsl:apply-templates select="document('boilerplates.xml')//*[@title='Security Requirements']"/>
  </xsl:template>

  <!-- ################################################## 

       ################################################## -->
  <xsl:template name="citeCC"><a href="#bibCC">[CC]</a></xsl:template>


  <!-- ################################################## 

       ################################################## -->
  <xsl:template match="/cc:Module//*[@title='TOE Security Functional Requirements']|/cc:Module//sec:TOE_Security_Functional_Requirements[not(@title)]" mode="hook">
    <xsl:choose>
      <xsl:when test="cc:*[@title='TOE Security Functional Requirements']">
The following section describes the SFRs that must be satisfied by any TOE that claims conformance to this PP-Module.
These SFRs must be claimed regardless of which PP-Configuration is used to define the TOE.
      </xsl:when>
      <xsl:otherwise>
This PP-Module does not define any mandatory SFRs that apply regardless of the PP-Configuration.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/cc:PP//*[./cc:OSPs]" mode="hook">
<!--   <xsl:if test="not(.//cc:OSP)">
   <p>    This PP defines no Organizational Security Policies.</p>
   </xsl:if>  -->
  </xsl:template>

  <xsl:template match="/cc:Module//*[./cc:SOs]" mode="hook">
   <!-- <xsl:if test="not(.//cc:SO)">
   <p>    This PP-Module defines no additional Security Objectives.</p>
   </xsl:if>  -->
  </xsl:template>


  <xsl:template match="/cc:Module//*[./cc:OSPs]" mode="hook">
   <p>An organization deploying the TOE is
      expected to satisfy the organizational security policy listed below in addition to all
      organizational security policies defined by the claimed Base-PP. </p>
<!--
   <xsl:if test="not(.//cc:OSP)">
   <p>    This PP-Module defines no additional Organizational Security Policies.</p>
   </xsl:if>-->
  </xsl:template>


<!-- #################### -->
  <xsl:template match="/cc:Module//*[@title='Assumptions']|/cc:Module//sec:Assumptions[not(@title)]" mode="hook">
    <xsl:choose>
      <xsl:when test="@boilerplate='no'"/>
      <xsl:when test=".//cc:assumption">
These assumptions are made on the Operational Environment (OE) in order to be able to ensure that the
security functionality specified in the PP-Module can be provided by the TOE.
If the TOE is placed in an OE that does not meet these assumptions, the TOE may no longer be able to
provide all of its security functionality.
      </xsl:when>
<!--      <xsl:otherwise>
This PP-Module defines no additional assumptions.
      </xsl:otherwise>-->
    </xsl:choose>
  </xsl:template>

<!-- #################### -->
  <xsl:template match="/cc:Module//cc:*[@title='Security Objectives for the Operational Environment']" mode="hook">
    <xsl:choose>
      <xsl:when test=".//cc:SOEs">
The OE of the TOE implements technical and procedural measures to assist the TOE in correctly providing its security functionality (which is defined by the security objectives for the TOE).
The security objectives for the OE consist of a set of statements describing the goals that the OE should achieve.
This section defines the security objectives that are to be addressed by the IT domain or by non-technical or procedural means.
The assumptions identified in Section 3 are incorporated as security objectives for the environment.
      </xsl:when>
      <xsl:otherwise>
This PP-Module does not define any objectives for the OE.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="sel-based-reqs" match="//cc:ref[@to='sel-based-reqs']"><!--
    --><a href="#sel-based-reqs" class='dynref'/><!-- 
  --></xsl:template>


  <xsl:template name="ref-obj-reqs" match="//cc:ref[@to='obj-reqs']">
    <a href="#objective-reqs" class='dynref'/>
  </xsl:template>


  <xsl:template name="ref-impl-reqs" match="//cc:ref[@to='impl-reqs']">
    <a href="#feat-based-reqs" class='dynref'/>
  </xsl:template>

  <xsl:template name="ref-strict-optional" match="//cc:ref[@to='ref-strict-optional']"><!--
    --><a href="#optional-reqs" class='dynref'/><!--
  --></xsl:template>

  <xsl:template name="opt_appendix">
    <h1 id="opt-app" class="indexable" data-level="A">Optional Requirements</h1>
    As indicated in the introduction to this <xsl:call-template name="doctype-short"/>, the baseline requirements (those that must be
	  performed by the TOE) are contained in the body of this <xsl:call-template name="doctype-short"/>.
    This appendix contains three other types of optional requirements that may be included in the ST, but are not required in order
	  to conform to this <xsl:call-template name="doctype-short"/>.
    However, applied modules, packages and/or use cases may refine specific requirements as mandatory. <br/><br/>

   The first type (<xsl:call-template name="ref-strict-optional"/>) are strictly optional requirements that are independent of the
	  TOE implementing any function.
   If the TOE fulfills any of these requirements or supports a certain functionality, the vendor is encouraged to include the SFRs
	  in the ST, but are not required in order to conform to this <xsl:call-template name="doctype-short"/>.<br/><br/>

  The second type (<xsl:call-template name="ref-obj-reqs"/>) are objective requirements that describe security functionality not yet 
	  widely available in commercial technology.
   The requirements are not currently mandated in the body of this <xsl:call-template name="doctype-short"/>, but will be included in
	  the baseline requirements in future versions of this <xsl:call-template name="doctype-short"/>. Adoption by vendors is
	  encouraged and expected as soon as possible.<br/><br/>

  The third type (<xsl:call-template name="ref-impl-reqs"/>) <xsl:call-template name="imple_text"/>
  </xsl:template>

  <xsl:template name="imple_text">
are dependent on the TOE implementing a particular function.
If the TOE fulfills any of these requirements, the vendor must either add the related SFR or disable the functionality for the
	  evaluated configuration. 
  </xsl:template>

</xsl:stylesheet>
