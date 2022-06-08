<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#default x">
	<xsl:output encoding="UTF-8" method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:param name="sCSSDir"/>
	<xsl:param name="sTitle" select="'ESPAÑOL-ENGLISH'"/>
	<xsl:param name="sBorradorFecha" select="'Borrador (3 Julio 2013)'"/>
	<xsl:param name="sStartingPageNumber" select="'213'"/>

	<!-- Set user's title -->
	<xsl:template match="x:title" priority="100">
		<title>
			<xsl:value-of select="$sTitle"/>
		</title>
	</xsl:template>

	<xsl:template match="x:link" priority="100">
		<!-- Use our modified version of Jim Albright's CSS -->
		<link rel="stylesheet" href="{$sCSSDir}FLExXHTML2MxbReversalXHTML.css" type="text/css"/>
		<!-- insert the footer content -->
		<meta name="footer" content="{$sBorradorFecha}"/>
		<!-- insert the starting page number , but does not work; have to change the CSS directly -->
		<!--<meta name="startingPageNumber" content="{$sStartingPageNumber}"/>-->
	</xsl:template>


	<!-- do not want extra spans containing spaces -->
	<xsl:template match="x:span[@xml:space='preserve' and string-length(normalize-space(.))=0][not(preceding-sibling::*[1][@class='Dictionary-Vernacular' or @class='Emphasized_Text'] and following-sibling::*[1][@class='Dictionary-Vernacular' or @class='Emphasized_Text'])]">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='&#xa0;']">
		<!-- throw these away -->
	</xsl:template>
	<!-- 
		No need for spans containing brackets, parens, or squiggle braces.
		We handled all these via the CSS
	-->
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='[']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)=']']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='(']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)=')']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='{']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='}']">
		<!-- throw these away -->
	</xsl:template>

	<!-- convert soft hyphen to regular hyphen -->
	<xsl:template match="text()[contains(.,'&#xad;')]">
		<xsl:value-of select="translate(.,'&#xad;','-')"/>
	</xsl:template>
	
	<xsl:template match="x:body" priority="150">
		<body class="dicBody">
			<xsl:apply-templates/>
		</body>
	</xsl:template>
	
	
	<!-- 
		Change class name
	-->
	<xsl:template match="@class" priority="100">
		<xsl:variable name="sNewClassName">
			<xsl:choose>
				<xsl:when test=".='Homograph-Number'">Homograph_Number</xsl:when>
				<xsl:when test=".='letData'">Letter_Data</xsl:when>
				<xsl:when test=".='letHead'">Letter_Heading</xsl:when>
				<xsl:when test=".='partofspeech'">Part_Of_Speech</xsl:when>
				<xsl:when test="starts-with(.,'subentries')">Subentry_Group</xsl:when>

				<!--<xsl:when test=".='complexform-summary'">Comment</xsl:when>
				<xsl:when test=".='crossref'">Cross_Reference</xsl:when>
				<xsl:when test=".='crossref-minor'">Cross_Reference</xsl:when>
				<xsl:when test=".='Emphasized_Text' and ../@lang='es'">Emphasized_TextSpanish</xsl:when>
				<xsl:when test=".='entry'">Main_Entry</xsl:when>
				<xsl:when test=".='examples'">Example_Group</xsl:when>
				<xsl:when test=".='LexEntry-publishStemComponentTarget-HeadWordRef'">Link_To_Lemma</xsl:when>
				<xsl:when test=".='LexEntry-publishStemMinorPrimaryTarget-HeadWordRef'">Variant_Form</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemMinorEntryType-AbbreviationPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemVariantType-ReverseAbbrPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemMinorVariantType-ReverseAbbrPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemVariantType%01-ReverseAbbrPub1.0.0'">Variant_Type</xsl:when>
				<xsl:when test=".='LexSense-publishStem-DefinitionPub'">Definition</xsl:when>
				<xsl:when test=".='minorentry'">Minor_Entry</xsl:when>
				<xsl:when test=".='partofspeech-complexform'">Part_Of_Speech</xsl:when>
				<xsl:when test=".='pictureCaption'">Picture_Caption</xsl:when>
				<xsl:when test=".='pictureRight'">Picture_Group</xsl:when>
				<xsl:when test=".='sense'">Sense_Group</xsl:when>
				<xsl:when test=".='variantrefs1'">Variant_Group</xsl:when>
				<xsl:when test=".='variantref-form'">Variant_Form</xsl:when>
				<xsl:when test=".='variantref-form-minor'">Variant_Form</xsl:when>
				<xsl:when test=".='variantref-form1.0'">Variant_Form</xsl:when>-->
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:attribute name="class">
			<xsl:value-of select="$sNewClassName"/>
		</xsl:attribute>
	</xsl:template>

	<!-- 
		Change class name and remove some material or make other changes or additions
	-->
	<xsl:template match="x:div[@class='reversalindexentry']" priority="100">
		<xsl:if test="count(*)!=0">
			<div class="Reversal_Entry">
				<xsl:apply-templates/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="x:span[@class='headref']">
		<xsl:variable name="sLang" select="@lang"/>
		<span class="Headword_Reference" lang="{@lang}">
			<xsl:apply-templates select="*[@lang=$sLang or @class='Homograph-Number']"/>
		</span>
	</xsl:template>

	<xsl:template match="x:span[@class='Homograph-Number']" mode="GuideWord">
		<xsl:value-of select="translate(.,'0123456789','&#x2080;&#x2081;&#x2082;&#x2083;&#x2084;&#x2085;&#x2086;&#x2087;&#x2088;&#x2089;')"/>
	</xsl:template>

	<xsl:template match="x:span[@class='restrictions']">
		<span class="Restriction" lang="{x:span/@lang}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="x:span[@class='reversalform'][parent::x:div[@class='reversalindexentry']]">
		<span class="Lemma" lang="{@lang}">
			<xsl:apply-templates/>
			<span class="GuideWord">
				<xsl:variable name="sGuideWord">
					<xsl:apply-templates mode="GuideWord"/>
				</xsl:variable>
				<xsl:value-of select="translate($sGuideWord,'&#xa0;','')"/>
			</span>
		</span>
	</xsl:template>
<!--	<xsl:template match="x:span[@class='reversal-form'][parent::x:div[@class='subentry']]">
		<span class="Subentry" lang="{@lang}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->
	<xsl:template match="x:span[@class='reversalform'][parent::x:span[starts-with(@class,'subentry')]]">
		<span class="Subentry" lang="{x:span/@lang}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="x:span[starts-with(@class,'subentry')]">
		<div class="subentry">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="x:span[@class='referringsenses'][parent::x:div[@class='reversalindexentry']] | x:span[@class='sensesrs'][parent::x:div[@class='reversalindexentry']]">
		<xsl:choose>
			<xsl:when test="descendant::x:a">
				<!-- older style export -->
				<xsl:choose>
					<xsl:when test="descendant::x:span[contains(@class,'sensenumber')]">
						<xsl:for-each select="descendant::x:span[@class='referringsense' or @class='sensesr']">
							<span class="Sense_Group">
<!--								<xsl:apply-templates select="descendant-or-self::x:span[@class='headword']/*"/>-->
								<xsl:apply-templates/>
							</span>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<span class="Headword_Reference" lang="{descendant-or-self::x:span/@lang}">
							<xsl:apply-templates/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- newer style export -->
				<xsl:call-template name="OutputSensesNewExportStyle">
					<xsl:with-param name="sGroupName" select="'Sense_Group'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="x:span[@class='referringsenses'][parent::x:span[starts-with(@class,'subentry')]] | x:span[@class='sensesrs'][parent::x:span[starts-with(@class,'subentry')]]">
		<xsl:choose>
			<xsl:when test="descendant::x:a">
				<!-- older style export -->
				<xsl:variable name="iSenseContent" select="count(x:span[@class='sensecontent'])"/>
				<xsl:choose>
					<xsl:when test="$iSenseContent &gt; 1">
						<xsl:for-each select="descendant::x:span[@class='referringsense' or @class='sensesr']">
							<span class="Subentry_Sense_Group">
								<xsl:apply-templates/>
							</span>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<span class="Headword_Reference" lang="{descendant-or-self::x:span/@lang}">
						<xsl:apply-templates/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- newer style export -->
				<xsl:call-template name="OutputSensesNewExportStyle">
					<xsl:with-param name="sGroupName" select="'Subentry_Sense_Group'"/>
				</xsl:call-template>
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
	<!--
		Remove color from styles 
	-->
	<xsl:template match="@style" priority="50">
		<xsl:attribute name="style">
			<xsl:call-template name="GetNonColorItemsFromStyleContent">
				<xsl:with-param name="sStyle" select="."/>
			</xsl:call-template>
		</xsl:attribute>
	</xsl:template>
	<!-- 
		Items to ignore 
	-->
	<xsl:template match="x:span[contains(@class,'xsensenumber')]"/>
	<!--
		GetNonColorItemsFromStyleContent
	-->
	<xsl:template name="GetNonColorItemsFromStyleContent">
		<xsl:param name="sStyle"/>
		<xsl:variable name="sNewList" select="normalize-space($sStyle)"/>
		<xsl:variable name="sFirst" select="substring-before($sNewList,';')"/>
		<xsl:variable name="sRest" select="substring-after($sNewList,';')"/>
		<xsl:if test="string-length($sFirst) &gt; 0">
<!--			<xsl:choose>
				<xsl:when test="starts-with($sFirst,'font-size:58%')">
					<xsl:text>font-size:xx-small;</xsl:text>
				</xsl:when>
				<xsl:when test="$sFirst='font-weight:bold'">
					<!-\- skip it -\->
				</xsl:when>
				<xsl:when test="not(starts-with($sFirst,'color'))">
					<xsl:value-of select="$sFirst"/>
					<xsl:text>;</xsl:text>
				</xsl:when>
			</xsl:choose>-->
			<xsl:if test="not(starts-with($sFirst,'color'))">
				<xsl:value-of select="$sFirst"/>
				<xsl:text>;</xsl:text>
			</xsl:if>
			<xsl:if test="$sRest">
				<xsl:call-template name="GetNonColorItemsFromStyleContent">
					<xsl:with-param name="sStyle" select="$sRest"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!--
	OutputSensesNewExportStyle
-->
	<xsl:template name="OutputSensesNewExportStyle">
		<xsl:param name="sGroupName"/>
		<xsl:choose>
			<xsl:when test="descendant::x:span[contains(@class,'sensenumber')]">
				<xsl:variable name="iCount" select="count(*)"/>
				<xsl:for-each select="descendant::x:span[contains(@class,'sensenumber')]">
					<xsl:variable name="iThisSenseNumberPos" select="count(preceding-sibling::*) + 1"/>
					<xsl:variable name="nextSenseNumber" select="following-sibling::x:span[contains(@class,'sensenumber')][1]"/>
					<xsl:variable name="iNextSenseNumberPos">
						<xsl:choose>
							<xsl:when test="$nextSenseNumber">
								<xsl:value-of select="count($nextSenseNumber/preceding-sibling::*) + 1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$iCount + 1"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<span class="{$sGroupName}">
						<xsl:apply-templates select="../*[position() &gt;= $iThisSenseNumberPos and position() &lt; $iNextSenseNumberPos]"/>
					</span>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
