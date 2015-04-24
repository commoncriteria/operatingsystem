<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
		xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:key name="abbr" match="cc:glossary/cc:entry/cc:term/cc:abbr" use="text()" />
  
  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="cc:linkref">
    <xsl:variable name="linkend" select="translate(@linkend,$lower,$upper)" />
    <xsl:variable name="linkendlower" select="translate(@linkend,$upper,$lower)" />

    <xsl:if test="not(//*[@id=$linkendlower])">
      <xsl:message>
    	Broken linked element at 
	<xsl:value-of select="$linkend"/>
      </xsl:message>
    </xsl:if>
    <xsl:value-of select="text()"/>
    <a class="linkref" href="#{$linkend}"><xsl:value-of select="$linkend" /></a>
  </xsl:template>

  <xsl:template match="cc:testlist">
    <ul>
      <xsl:apply-templates />
    </ul>
  </xsl:template>

  <xsl:template match="cc:test">
    <li>
      <b>Test <xsl:for-each select="ancestor::cc:test"><xsl:value-of select="count(preceding-sibling::cc:test) + 1" />.</xsl:for-each><xsl:value-of select="count(preceding-sibling::cc:test) + 1" />: </b>
      <xsl:apply-templates />
    </li>
  </xsl:template>

  <xsl:template match="cc:abbr[@linkend]">
    <xsl:variable name="target" select="key('abbr', @linkend)" />
    <xsl:variable name="abbr" select="$target/text()" />
    
    <a class="abbr" href="#abbr_{$abbr}"><abbr title="{$target/@title}"><xsl:value-of select="$abbr" /></abbr></a>
  </xsl:template>

  <xsl:template match="cc:selectables">
    [<b>selection</b><xsl:if test="@exclusive">, choose one of</xsl:if><xsl:if test="@atleastone">, at least one of</xsl:if>: <xsl:for-each select="cc:selectable"><xsl:choose><xsl:when test="../@linebreak"><p style="margin-left: 40px;"><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></p></xsl:when><xsl:otherwise><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></xsl:otherwise></xsl:choose></xsl:for-each>]
  </xsl:template>

  <xsl:template match="cc:assignable">
    [<b>assignment</b>: <xsl:apply-templates />]
  </xsl:template>

  <xsl:template match="cc:note[@role='application']">
    <div class="appnote">
      <b>Application Note: </b>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="cc:inline-comment[@level='critical']">
    <xsl:if test="$release!='draft'">
      <xsl:message terminate="yes">
    	Must fix elements must be fixed before a release version can be generated:
    	<xsl:value-of select="text()"/>
      </xsl:message>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cc:inline-comment">
    <xsl:choose>
      <xsl:when test="@linebreak='yes'">
	<xsl:element name="div">
	  <xsl:attribute name="style">background-color: beige; color:<xsl:value-of select="@color"/></xsl:attribute>
	  <xsl:value-of select="text()"/>
	</xsl:element>
      </xsl:when>
      <xsl:otherwise>
	<xsl:element name="span">
	  <xsl:attribute name="style">background-color: beige; color:<xsl:value-of select="@color"/></xsl:attribute>
	  <xsl:value-of select="text()"/>
	</xsl:element>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <!-- Eat all comments! -->
  <xsl:template match="comment()"/>
    
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="processing-instruction('xml-stylesheet')"/>


  <xsl:template match="cc:management-function-set">
    <table style="width: 100%;" xmlns="http://common-criteria.rhcloud.com/ns/cc">
      <tr class="header">
	<td>Management Function</td>
	<xsl:apply-templates select="./cc:manager"/>
      </tr>
      <xsl:apply-templates select="./cc:management-function"/>
    </table>
  </xsl:template>

  <xsl:template match="cc:manager">
    <td><xsl:apply-templates/></td>
  </xsl:template>

  <xsl:template match="cc:management-function">
    <tr><td><xsl:apply-templates/></td>
    <td>
    <xsl:choose>
     <xsl:when test="@admin">
       <xsl:value-of select="@admin"/>
     </xsl:when>
     <xsl:otherwise>O</xsl:otherwise>
    </xsl:choose>
    </td>

    <td>
    <xsl:choose>
     <xsl:when test="@user">
       <xsl:value-of select="@user"/>
     </xsl:when>
     <xsl:otherwise>O</xsl:otherwise>
    </xsl:choose>
    </td>

    </tr>
  </xsl:template>


</xsl:stylesheet>
