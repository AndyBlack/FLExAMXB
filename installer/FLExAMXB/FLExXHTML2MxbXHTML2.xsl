<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#default x">
	<xsl:output encoding="UTF-8" method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

	<!-- 
	Create Reference Paragraph sections
-->
<!--	<xsl:template match="x:span[starts-with(@class,'primaryrefs') and not(preceding-sibling::x:span[@class='Notes_Grammar']) and not(preceding-sibling::x:span[@class='Linguistic_Information_Group']) and not(preceding-sibling::x:span[@class='Cross_Reference_Type'])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
			<!-\-<xsl:if test="x:span[@class='Linguistic_Information_Group']">
				<span class="Linguistic_Information_Group" lang="{@lang}">
				<xsl:apply-templates select="following-sibling::x:span[@class='Linguistic_Information_Group']" mode="reference_paragraph"/>
				</span>
				</xsl:if>-\->
			<xsl:apply-templates select="following-sibling::x:span[@class='Notes_Grammar' or @class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal' or @class='xitem']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
--><!--	<xsl:template match="x:span[@class='Notes_Grammar' and not(preceding-sibling::x:span[starts-with(@class,'primaryrefs')])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
			<!-\-<xsl:if test="x:span[@class='Linguistic_Information_Group']">
				<span class="Linguistic_Information_Group" lang="{@lang}">
					<xsl:apply-templates select="following-sibling::x:span[@class='Linguistic_Information_Group']" mode="reference_paragraph"/>
				</span>
			</xsl:if>-\->
			<xsl:apply-templates select="following-sibling::x:span[@class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal' or @class='xitem']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='Linguistic_Information_Group' and not(preceding-sibling::x:span[@class='Notes_Grammar' or @class='primaryrefs'])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
			<xsl:apply-templates select="following-sibling::x:span[@class='Variant_Group' or @class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal' or @class='xitem']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='Variant_Group' and not(preceding-sibling::x:span[@class='Notes_Grammar' or @class='Linguistic_Information_Group' or @class='primaryrefs'])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
			<xsl:apply-templates select="following-sibling::x:span[@class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='xitem' and descendant::x:span[@class='Cross_Reference_Type'] and not(preceding-sibling::x:span[@class='Notes_Grammar' or @class='primaryrefs' or @class='Linguistic_Information_Group' or @class='Variant_Group' or @class='xitem' and descendant::x:span[@class='Cross_Reference_Type']])]" priority="100">
		<!-\- TODO: what about primaryrefs after? But this is the same thing...-\->
		<span class="Reference_Paragraph">
			<xsl:copy-of select="*"/>
			<xsl:apply-templates select="following-sibling::x:span[@class='xitem' and descendant::x:span[@class='Cross_Reference_Type'] or @class='Normal']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='Cross_Reference_Type' and not(preceding-sibling::x:span[@class='Notes_Grammar' or @class='primaryrefs' or @class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type']) and not(../preceding-sibling::x:span[@class='xitem' and descendant::x:span[@class='Cross_Reference_Type'] or @class='Notes_Grammar' or @class='Linguistic_Information_Group' or @class='Variant_Group'])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
			<xsl:apply-templates select="following-sibling::x:span[starts-with(@class,'crossref-targets') or @class='Cross_Reference_Type' or starts-with(@class,'primaryrefs') or @class='Normal']" mode="reference_paragraph"/>
		</span>
	</xsl:template>
<!-\-	<xsl:template match="x:span[starts-with(@class,'primaryrefs') and not(preceding-sibling::x:span[@class='Notes_Grammar' or @class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type'])]" priority="100">
		<span class="Reference_Paragraph">
			<xsl:copy-of select="."/>
		</span>
	</xsl:template>-\->
	<xsl:template match="x:span[@class='Notes_Grammar' or @class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal']" mode="reference_paragraph">
		<xsl:copy-of select="."/>
	</xsl:template>
	<!-\- skip when already done -\->
	<xsl:template match="x:span[@class='Linguistic_Information_Group' or @class='Variant_Group' or @class='Cross_Reference_Type' or starts-with(@class,'crossref-targets') or starts-with(@class,'primaryrefs') or @class='Normal' or @class='xitem' and preceding-sibling::x:span[@class='Notes_Grammar']]">
		<xsl:choose>
			<xsl:when test="@class='Normal' and ancestor::x:span[@class='Variant_Group_Minor']">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<!-\- skip, already handled -\->		
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->	<!-- 
	basic copy template 
-->
	<xsl:template match="node() | @*" priority="0">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<!-- 
	Items to ignore 
-->
<!--	<xsl:template match="x:span[@class='xsensenumber']"/>
	<xsl:template match="x:span[@class='Notes_Grammar']"/>-->
</xsl:stylesheet>
