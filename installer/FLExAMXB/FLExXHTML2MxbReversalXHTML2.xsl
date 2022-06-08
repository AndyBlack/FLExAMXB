<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#default x">
	<xsl:output encoding="UTF-8" method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

	<xsl:template match="x:span[@class='Subentry_Sense_Group' and descendant::x:span[@class='Restriction'] and following-sibling::*[1][name()='span' and @class='Subentry_Sense_Group' and descendant::x:span[@class='Restriction']]]">
		<xsl:variable name="sThisRestriction">
			<xsl:value-of select="normalize-space(x:span[@class='Restriction'])"/>
		</xsl:variable>
		<xsl:variable name="sNextRestriction">
			<xsl:value-of select="normalize-space(following-sibling::*[1][name()='span' and @class='Subentry_Sense_Group' and descendant::x:span[@class='Restriction']]/descendant::x:span[@class='Restriction'])"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$sThisRestriction=$sNextRestriction">
<!--				<xsl:variable name="iCountOfSubentrySenseGroups" select="count(following-sibling::*[name()='span' and @class='Subentry_Sense_Group'])"/>-->
				<xsl:variable name="iCountOfSubentrySenseGroups" select="count(following-sibling::*[name()='span' and @class='Subentry_Sense_Group']) + count(preceding-sibling::*[name()='span' and @class='Subentry_Sense_Group'])"/>
				<xsl:choose>
					<xsl:when test="$iCountOfSubentrySenseGroups=1">
						<span class="Subentry_Sense_Group_Same_Restriction_Single">
							<xsl:apply-templates select="*[@class!='Restriction']"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span class="Subentry_Sense_Group_Same_Restriction">
							<xsl:apply-templates select="*[@class!='Restriction']"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<span class="Subentry_Sense_Group">
					<xsl:apply-templates select="*"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
		basic copy template 
	-->
	<xsl:template match="node() | @*" priority="0">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
