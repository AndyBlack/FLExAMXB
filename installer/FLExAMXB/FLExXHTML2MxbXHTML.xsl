<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#default x ">
	<xsl:output encoding="UTF-8" method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:param name="sCSSDir"/>
	<xsl:param name="sTitle" select="'ENGLISH-ESPAÑOL'"/>
	<xsl:param name="sBorradorFecha" select="'Borrador (1 Mayo 2013)'"/>

	<xsl:param name="sLinkedFilesPath" select="translate(//x:meta[@name='linkedFilesRootDir']/@content,'\','/')"/>

	<!-- Set user's title -->
	<xsl:template match="x:title" priority="100">
		<title>
			<xsl:value-of select="$sTitle"/>
		</title>
	</xsl:template>

	<xsl:template match="x:link" priority="100">
		<!-- Use our modified version of Jim Albright's CSS -->
		<link rel="stylesheet" href="{$sCSSDir}Dictionary MXB XHTML.css" type="text/css"/>
		<!-- insert the footer content -->
		<meta name="footer" content="{$sBorradorFecha}"/>
	</xsl:template>

	<!-- pictures come out in the wrong order so we need to do the entry first and then the picture -->
	<xsl:template match="x:div[@class='entry' or @class='minorentry'][child::*[1][name()='div' and @class='pictureRight']]">
		<x:div id="{@id}">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@class='entry'">Main_Entry</xsl:when>
					<xsl:otherwise>Minor_Entry</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<!-- do the entry processing -->
			<xsl:apply-templates select="child::*[position()!=1]"/>
			<!--  now do the picture -->
			<xsl:apply-templates select="child::*[position()=1]"/>
		</x:div>
	</xsl:template>

	<!-- do not want extra spans containing spaces -->
	<xsl:template
		match="x:span[@xml:space='preserve' and string-length(normalize-space(.))=0][not(preceding-sibling::*[1][@class='Dictionary-Vernacular' or @class='Emphasized_Text'] and following-sibling::*[1][@class='Dictionary-Vernacular' or @class='Emphasized_Text'])]">
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
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='&#xa0;[']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)=']']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='(']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='&#xa0;(']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)=')']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='{']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='&#xa0;{']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)='}']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@xml:space='preserve' and normalize-space(.)=',']">
		<!-- throw these away -->
	</xsl:template>
	<xsl:template match="x:span[@class='altura-de-la-imagen']">
		<!-- throw these away (handled by Picture_Group) -->
	</xsl:template>

	<!-- convert soft hyphen to regular hyphen -->
	<xsl:template match="text()[contains(.,'&#xad;')]">
		<xsl:value-of select="translate(.,'&#xad;','-')"/>
	</xsl:template>

	<!-- rework picture location to absolute location -->
	<xsl:template match="x:img" priority="100">
				<img class="{@class}" src="file://{$sLinkedFilesPath}/{@src}" alt="file://{$sLinkedFilesPath}/{@alt}"/>
<!--		<img class="{@class}" src="{@src}" alt="{@alt}"/>-->
	</xsl:template>
	<!-- 
	Change class name
-->
	<xsl:template match="@class" priority="100">
		<xsl:variable name="sNewClassName">
			<xsl:choose>
				<!--				<xsl:when test=".='complexform'">Subentry_Group</xsl:when>-->
				<xsl:when test="starts-with(.,'subentries')">Subentry_Group</xsl:when>
				<xsl:when test=".='complexformrefs'">Subentry_Group</xsl:when>
				<xsl:when test=".='complexform-summary'">Comment</xsl:when>
				<xsl:when test=".='crossref'">Cross_Reference</xsl:when>
				<xsl:when test=".='sense-crossref'">Cross_Reference</xsl:when>
				<xsl:when test=".='crossref-minor'">Cross_Reference</xsl:when>
				<xsl:when test=".='Emphasized_Text' and ../@lang='es'">Emphasized_TextSpanish</xsl:when>
				<xsl:when test=".='entry'">Main_Entry</xsl:when>
				<xsl:when test=".='examples'">Example_Group</xsl:when>
				<!--				<xsl:when test=".='headword'">Lemma</xsl:when>-->
				<!--				<xsl:when test=".='headword-minor'">Lemma</xsl:when>-->
				<xsl:when test=".='letData'">Letter_Data</xsl:when>
				<xsl:when test=".='letHead'">Letter_Heading</xsl:when>
				<xsl:when test=".='LexEntry-publishStemComponentTarget-HeadWordRef'">Link_To_Lemma</xsl:when>
				<xsl:when test=".='LexEntry-publishStemMinorPrimaryTarget-HeadWordRef'">Variant_Form</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemMinorEntryType-AbbreviationPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemVariantType-ReverseAbbrPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemMinorVariantType-ReverseAbbrPub'">Variant_Type</xsl:when>
				<xsl:when test=".='LexEntryType-publishStemVariantType%01-ReverseAbbrPub1.0.0'">Variant_Type</xsl:when>
				<xsl:when test="starts-with(.,'LexEntryType-publishStemVariantType')">Variant_Type</xsl:when>
				<xsl:when test="starts-with(.,'LexEntryType-publishStemMinorVariantType')">Variant_Type</xsl:when>
				<xsl:when test=".='variantentrytype'">Variant_Type</xsl:when>
				<xsl:when test=".='LexSense-publishStem-DefinitionPub'">Definition</xsl:when>
				<xsl:when test=".='LexSense-publishStem-Picture--Height'">PictureHeight</xsl:when>
				<xsl:when test=".='definition'">Definition</xsl:when>
				<xsl:when test=".='minorentry'">Minor_Entry</xsl:when>
				<xsl:when test=".='minorentryvariant'">Minor_Entry</xsl:when>
				<xsl:when test="starts-with(.,'partofspeech')">Part_Of_Speech</xsl:when>
				<xsl:when test="starts-with(.,'graminfoabbrev')">Part_Of_Speech</xsl:when>
				<!--<xsl:when test=".='partofspeech-complexform'">Part_Of_Speech</xsl:when>-->
				<xsl:when test=".='pictureCaption'">Picture_Caption</xsl:when>
				<xsl:when test=".='caption'">Picture_Caption</xsl:when>
				<xsl:when test=".='pictureRight'">Picture_Group</xsl:when>
				<xsl:when test=".='picturesofsense'">Picture_Group</xsl:when>
				<xsl:when test=".='LexEntry-publishStemPara-Región--de--la--variante'">Regional_Variant</xsl:when>
				<xsl:when test=".='sense'">Sense_Group</xsl:when>
				<xsl:when test="starts-with(.,'variantrefs')">Variant_Group</xsl:when>
				<xsl:when test="starts-with(.,'variantref-form')">Variant_Form</xsl:when>
				<xsl:when test=".='variantformentrybackref_inflectional-variants'">Variant_Form</xsl:when>
				<!--<xsl:when test=".='variantref-form-minor'">Variant_Form</xsl:when>
				<xsl:when test=".='variantref-form1.0'">Variant_Form</xsl:when>-->
				<xsl:when test=".='xhomographnumber'">Homograph_Number</xsl:when>
				<xsl:when test=".='LexEntry-publishStemPara-HomographNumber'">Homograph_Number</xsl:when>
				<xsl:when test="contains(.,'prefijo')">Prefijo</xsl:when>
				<xsl:when test="contains(.,'Prefijo')">Prefijo</xsl:when>
				<xsl:when test="contains(.,'mainentrysubsense')">Subsense</xsl:when>
				<xsl:when test=".='grouping_referencessection'">Reference_Paragraph</xsl:when>
				<xsl:when test=".='dialectlabelsr'">Dialect</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:attribute name="class">
			<xsl:value-of select="$sNewClassName"/>
		</xsl:attribute>
		<xsl:if test="$sNewClassName='Picture_Group'">
			<xsl:variable name="pictureHeight" select="../../preceding-sibling::x:span[@class='senses']/descendant::x:span[@class='altura-de-la-imagen']/x:span/x:span"/>
			<xsl:attribute name="style">
				<xsl:text>height:</xsl:text>
				<xsl:choose>
					<xsl:when test="$pictureHeight">
						<xsl:value-of select="$pictureHeight"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>1in</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xsl:template match="x:body" priority="150">
		<body class="dicBody">
			<xsl:apply-templates/>
		</body>
	</xsl:template>
	<!-- 
	Keep class name but change div to span
	-->
	<xsl:template match="x:div[@class='complexform']">
		<span class="complexform">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:div[@class='subentry' and position()=last()]">
		<span class="subentry">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- 
	Change class name and remove some material
-->
	<xsl:template match="x:span[starts-with(@class,'subentry')]">
		<div class="subentry">
			<span class="subentry">
				<span class="Subentry" lang="{x:span/x:span/@lang}">
					<xsl:call-template name="DoFormWithHomographNumber"/>
				</span>
				<span class="Part_Of_Speech">
					<xsl:choose>
						<xsl:when test="descendant-or-self::x:span[@class='sharedgrammaticalinfo']">
							<xsl:apply-templates select="descendant-or-self::x:span[@class='sharedgrammaticalinfo']"/>
						</xsl:when>
						<xsl:when test="count(descendant-or-self::x:span[@class='graminfoabbrev']) &gt; 1">
							<xsl:for-each select="descendant-or-self::x:span[@class='graminfoabbrev']">
								<xsl:if test="position()!=1">
									<xsl:text>; </xsl:text>
								</xsl:if>
								<xsl:value-of select="."/>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</span>
				<span class="Definition">
					<xsl:apply-templates select="descendant-or-self::x:span[@class='summarydefinition' or @class='restrictions' or @class='descripción-breve']"/>
				</span>
			</span>
		</div>
	</xsl:template>
	<xsl:template match="x:span[@class='complexform-summary']">
		<span class="Comment" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and brackets, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='complexform-summarydef']">
		<span class="Definition" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='minimallexreferences']">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="x:span[@class='complexformtype']">
		<span class="Cross_Reference_Type" lang="{x:span[1]/x:span[1]/@lang}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='minimallexreference']">
		<span class="Cross_Reference_Type" lang="{x:span[1]/x:span[1]/@lang}">
			<xsl:apply-templates select="x:span[@class!='configtargets']"/>
		</span>
		<xsl:apply-templates select="x:span[@class='configtargets']"/>
	</xsl:template>
	<xsl:template match="x:span[@class='configtarget']">
		<span class="Cross_Reference" lang="{x:span[1]/x:span[1]/@lang}">
			<xsl:call-template name="DoFormWithHomographNumber"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='Default_Paragraph_Characters' and @xml:space='preserve']" priority="500">
		<!-- keep these -->
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="x:span[@class='encyclopedic-info' or @class='encyclopedicinfo']">
		<span class="Encyclopedic_Information" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and parens, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'example') and not(contains(@class, 'examples'))]">
		<span class="Example" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'examples')]">
		<xsl:if test="following-sibling::x:span[1][@class='subsenses']">
			<xsl:for-each select="following-sibling::x:span[1][@class='subsenses']/x:span[@class='sense']">
				<xsl:apply-templates select="*"/>
			</xsl:for-each>
		</xsl:if>
		<span class="Example_Group">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='headword' or @class='mainheadword' or @class='headword-minor']">
		<span class="Lemma" lang="{x:span/@lang}">
			<!-- only need the second span which has the contents -->
			<xsl:choose>
				<xsl:when test="following-sibling::x:span[contains(@class,'pronunciations')]">
					<xsl:call-template name="DoFormWithHomographNumber"/>
<!--					<xsl:apply-templates select="text() | x:span[@class='xhomographnumber'] | following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']" mode="HomographNumber"/>-->
				</xsl:when>
				<xsl:when test="following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']">
					<xsl:apply-templates select="text() | following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']" mode="HomographNumber"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="DoFormWithHomographNumber"/>
				</xsl:otherwise>
			</xsl:choose>
			<span class="GuideWord">
				<xsl:variable name="sGuideWord">
					<xsl:choose>
						<!--<xsl:when test="following-sibling::x:span[contains(@class,'pronunciations')]">
<!-\-							<xsl:apply-templates select="text() | x:span[@class='xhomographnumber'] | following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']" mode="GuideWord"/>-\->
							<xsl:apply-templates select="descendant-or-self::x:a" mode="GuideWord"/>
						</xsl:when>-->
						<xsl:when test="following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']">
							<xsl:apply-templates select="text() | following-sibling::x:span[@class='LexEntry-publishStemPara-HomographNumber']" mode="GuideWord"/>
						</xsl:when>
						<xsl:otherwise>
							<!--							<xsl:apply-templates mode="GuideWord"/>-->
							<xsl:apply-templates select="descendant-or-self::x:a" mode="GuideWord"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="translate($sGuideWord,'&#xa0;','')"/>
			</span>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='comment' and parent::x:span[@class='grouping_referencessection']]">
		<span class="Notes_Grammar" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and brackets, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexEntry-publishStemPara-CommentPub' or @class='LexEntry-publishStemMinorPara-CommentPub']">
		<span class="Notes_Grammar" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and brackets, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexEntry-publishStemMinorPara-Descripción--breve']">
		<span class="Description_Brief">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexEntryType-publishStemEntryType-AbbreviationPub']">
		<span class="Cross_Reference_Type" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexEntryType-publishStemMinorEntryType-AbbreviationPub']">
		<span class="Variant_Type" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexSense-publishStem-Comentario--restrictivo' or @class='comentario-restrictivo']">
		<span class="Restriction" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and parens, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='definición-descriptiva']">
		<xsl:call-template name="DoDefinitionDescriptive"/>
	</xsl:template>
	<xsl:template match="x:span[@class='LexSense-publishStem-Definición--descriptiva']">
		<xsl:call-template name="DoDefinitionDescriptive"/>
	</xsl:template>
	<xsl:template name="DoDefinitionDescriptive">
		<xsl:variable name="sClassName">
			<xsl:choose>
				<xsl:when test="x:span[starts-with(.,'P.') or contains(.,' p.')]">
					<xsl:text>Definition_Descriptive</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Definition_Descriptive_Long</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<span class="{$sClassName}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='LexSense-publishStemMinor-Definición--descriptiva']">
		<xsl:call-template name="DoDefinitionDescriptive"/>
	</xsl:template>
	<!--<xsl:template match="x:span[@class='partofspeech']">
		<span class="Part_Of_Speech" lang="{@lang}">
			<xsl:for-each select="*">
				<xsl:if test="position()!=1 and position()!=last()">
					<!-\- only need the middle pieces -\->
					<xsl:apply-templates/>
				</xsl:if>
			</xsl:for-each>
		</span>
	</xsl:template>-->
	<xsl:template match="x:span[@class='primaryrefs'][preceding-sibling::*[1][@class='crossrefs']]">
		<xsl:variable name="sPreviousType" select="preceding-sibling::*[1]/descendant::x:span[@class='crossref-type']"/>
		<xsl:variable name="sThisType" select="x:span[@class='entryref-type']"/>
		<xsl:choose>
			<xsl:when test="normalize-space($sPreviousType)=normalize-space($sThisType)">
				<span class="primaryrefsContinued">
					<x:span class="Normal">, </x:span>
					<xsl:apply-templates select="x:span[@class='entryref-component']"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="primaryrefs">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="x:span[@class='visiblevariantentryrefs']">
		<span class="Variant_Group_Minor" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and brackets, we can apply all of them -->
			<xsl:apply-templates select="descendant-or-self::x:span[@class='variantentrytypes']"/>
			<xsl:apply-templates select="descendant-or-self::x:span[@class='referencedentry']"/>
			<!--			<xsl:apply-templates select="descendant-or-self::x:span[@class='visiblevariantentryref']"/>-->
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='pronunciation' or @class='pronunciation-minor']">
		<span class="Pronunciation" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and parens, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='pronunciations']">
		<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="x:span[@class='restrictions']">
		<span class="Restriction" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and parens, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='restrictionsentry-minor']">
		<span class="Restriction" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces and parens, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='scientificname']">
		<span class="Scientific_Name">
			<!-- as long as we catch the ones containing just spaces and brackets, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='summarydef-minor']">
		<span class="Translation" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='summarydefinition']">
		<span class="Translation" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='translation']">
		<span class="Translation" lang="{@lang}">
			<!-- as long as we catch the ones containing just spaces, we can apply all of them -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template
		match="x:span[@class='sense' and count(../preceding-sibling::*/descendant-or-self::x:span[@class='sense'])+count(../following-sibling::*/descendant-or-self::x:span[@class='sense'])=0]">
		<span class="Sense_Group1">
			<!-- only use the single sense -->
			<xsl:apply-templates select="*"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'senses') and count(x:span[@class='sense'])=1]">
		<!-- only use the single sense -->
		<xsl:apply-templates select="x:span[@class='sense'][1]"/>
	</xsl:template>
	<xsl:template match="x:span[@class='partofspeech'][ancestor::x:span[@class='subsenses']]">
		<!-- never output the part of speech of a sense in a subsense because they are supposed to all be the same as the main sense;
		   (subsenses are really being used as a way to have more than one definition, each followed by a different restriction;
		   they are not true subsenses)
		-->
	</xsl:template>
	<xsl:template match="x:span[@class='sense'][parent::x:span[@class='subsenses']and preceding-sibling::x:span[@class='sense']]">
		<!-- non-initial sense in a list of subsenses are separated by a comma and a space -->
		<xsl:text>, </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'variantref-entry-type')]">
		<!-- only use the type -->
		<xsl:apply-templates select="*[1]"/>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'variantrefs') and not(contains(@class,'1'))]">
		<span class="Linguistic_Information_Group">
			<!-- skip the opening and closing square brackets (handled by the CSS now) -->
			<xsl:apply-templates select="*[position()!=1 and position()!=last()]"/>
		</span>
	</xsl:template>
	<xsl:template match="x:span[starts-with(@class,'variantformentrybackrefs_inflectional-variants')]">
		<span class="Linguistic_Information_Group">
			<xsl:for-each select="x:span[@class='variantentrytypes' or @class='variantformentrybackref_inflectional-variants']">
				<xsl:choose>
					<xsl:when test="descendant-or-self::x:span[@class='variantentrytype']">
						<xsl:apply-templates select="descendant-or-self::x:span[@class='variantentrytype']"/>
					</xsl:when>					
					<xsl:otherwise>
						<span class="Variant_Form">
							<xsl:call-template name="DoFormWithHomographNumber"/>
						</span>	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</span>
	</xsl:template>
	<xsl:template match="x:span[@class='variant-type-minor']">
		<!-- only use the type -->
		<xsl:apply-templates select="*[1]"/>
	</xsl:template>
	<xsl:template match="x:a" mode="GuideWord">
		<xsl:value-of select="translate(.,'0123456789','&#x2080;&#x2081;&#x2082;&#x2083;&#x2084;&#x2085;&#x2086;&#x2087;&#x2088;&#x2089;')"/>
	</xsl:template>
	<xsl:template match="x:span[@class='xhomographnumber' or @class='LexEntry-publishStemPara-HomographNumber']" mode="GuideWord">
		<xsl:value-of select="translate(.,'0123456789','&#x2080;&#x2081;&#x2082;&#x2083;&#x2084;&#x2085;&#x2086;&#x2087;&#x2088;&#x2089;')"/>
	</xsl:template>
	<!-- 
	combine similar variant types and forms
	-->
	<!-- main entry -->
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'variantrefs')] and preceding-sibling::x:span[@class='xitem']]">
		<xsl:variable name="precedingType"
			select="preceding-sibling::x:span[@class='xitem'][1]/descendant::x:span[starts-with(@class,'LexEntryType-publishStemVariantType') or starts-with(@class,'LexEntryType-publishStemMinorVariantType')]"/>
		<xsl:variable name="thisType" select="descendant::x:span[starts-with(@class,'LexEntryType-publishStemVariantType') or starts-with(@class,'LexEntryType-publishStemMinorVariantType')]"/>
		<xsl:if test="$precedingType!=$thisType or not($precedingType)">
			<xsl:apply-templates select="x:span[starts-with(@class,'variantref-entry-type')]"/>
		</xsl:if>
		<xsl:apply-templates select="x:span[starts-with(@class,'variantref-form')]"/>
	</xsl:template>
	<!-- minor entry -->
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'primaryrefs-minor')] and preceding-sibling::x:span[@class='xitem']]">
		<xsl:variable name="precedingType" select="preceding-sibling::x:span[@class='xitem'][1]/descendant::x:span[starts-with(@class,'LexEntryType-publishStemMinorEntryType')]"/>
		<xsl:variable name="thisType" select="descendant::x:span[starts-with(@class,'LexEntryType-publishStemMinorEntryType')]"/>
		<xsl:if test="$precedingType!=$thisType or not($precedingType)">
			<xsl:apply-templates select="x:span[starts-with(@class,'LexEntryType-publishStemMinorEntryType')]"/>
		</xsl:if>
		<xsl:apply-templates select="x:span[starts-with(@class,'variant-primary-minor')]"/>
	</xsl:template>

	<!-- main entry -->
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'variantrefs')] and not(preceding-sibling::x:span[@class='xitem'])]">
		<xsl:apply-templates select="x:span[starts-with(@class,'variantref-entry-type')] | x:span[starts-with(@class,'variantref-form')]"/>
	</xsl:template>
	<!-- minor entry -->
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'primaryrefs-minor')] and not(preceding-sibling::x:span[@class='xitem'])]">
		<xsl:apply-templates select="x:span[starts-with(@class,'variant-type-minor')] | x:span[starts-with(@class,'variant-primary-minor')]"/>
	</xsl:template>

	<!-- main entry -->
	<xsl:template match="x:span[not(@class)][preceding-sibling::*[1][@class='xitem' and parent::x:span[starts-with(@class,'variantrefs')]] and following-sibling::*]" priority="100">
		<xsl:choose>
			<xsl:when test="following-sibling::*[1][@class='xitem'][descendant::x:span[contains(@class,'publishStemVariantType') or contains(@class,'publishStemMinorVariantType')]]">
				<xsl:variable name="precedingType" select="preceding-sibling::*[1]/descendant::x:span[contains(@class,'publishStemVariantType') or contains(@class,'publishStemMinorVariantType')]"/>
				<xsl:variable name="followingType" select="following-sibling::*[1]/descendant::x:span[contains(@class,'publishStemVariantType') or contains(@class,'publishStemMinorVariantType')]"/>
				<xsl:choose>
					<xsl:when test="$precedingType=$followingType">
						<x:span class="Normal">, </x:span>
					</xsl:when>
					<xsl:otherwise>
						<!--	do not want this now					<xsl:value-of select="."/>-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="following-sibling::*[1][@class='xitem'][descendant::x:span[contains(@class,'variantref-form')]]">
				<!-- the variant type is missing; is an error -->
				<x:span class="Normal">; </x:span>
				<!--	It also gets caught with the form, so we report it there		<x:span class="Variant_Type_Missing"/>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::*"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- minor entry -->
	<xsl:template match="x:span[not(@class)][preceding-sibling::*[1][@class='xitem' and parent::x:span[starts-with(@class,'primaryrefs-minor')]] and following-sibling::*]" priority="100">
		<xsl:choose>
			<xsl:when test="following-sibling::*[1][@class='xitem'][descendant::x:span[contains(@class,'publishStemMinorEntryType')]]">
				<xsl:variable name="precedingType" select="preceding-sibling::*[1]/descendant::x:span[contains(@class,'publishStemMinorEntryType')]/x:span[1]"/>
				<xsl:variable name="followingType" select="following-sibling::*[1]/descendant::x:span[contains(@class,'publishStemMinorEntryType')]/x:span[1]"/>
				<xsl:choose>
					<xsl:when test="$precedingType=$followingType">
						<x:span class="Normal">, </x:span>
					</xsl:when>
					<xsl:otherwise>
						<!--	do not want this now					<xsl:value-of select="."/>-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="following-sibling::*[1][@class='xitem'][descendant::x:span[contains(@class,'variant-primary-minor')]]">
				<!-- the variant type is missing; is an error -->
				<x:span class="Normal">; </x:span>
				<!--	It also gets caught with the form, so we report it there		<x:span class="Variant_Type_Missing"/>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::*"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- main entry -->
	<xsl:template match="x:span[starts-with(@class,'variantref-form')]">
		<xsl:variable name="ps" select="preceding-sibling::*[1]"/>
		<xsl:if test="not($ps)">
			<!-- the variant type is missing; is an error -->
			<x:span class="Variant_Type_Missing"/>
		</xsl:if>
		<xsl:variable name="sFollowingForm" select="../following-sibling::x:span[@class='xitem'][1]/x:span[starts-with(@class,'variantref-form')]"/>
		<xsl:choose>
			<xsl:when test="$sFollowingForm=.">
				<span class="Normal">, </span>
			</xsl:when>
			<xsl:otherwise>
				<span class="Variant_Form" lang="{@lang}">
					<xsl:apply-templates select="text()|*"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- minor entry -->
	<xsl:template match="x:span[starts-with(@class,'variant-primary-minor')]">
		<xsl:variable name="ps" select="preceding-sibling::*[1]"/>
		<xsl:if test="not($ps)">
			<!-- the variant type is missing; is an error -->
			<x:span class="Variant_Type_Missing"/>
		</xsl:if>
		<xsl:variable name="sFollowingForm" select="../following-sibling::x:span[@class='xitem'][1]/x:span[starts-with(@class,'variant-primary-minor')]"/>
		<xsl:choose>
			<xsl:when test="$sFollowingForm=.">
				<span class="Normal">, </span>
			</xsl:when>
			<xsl:otherwise>
				<span class="Variant_Form" lang="{@lang}">
					<xsl:apply-templates select="text()|*"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- 
	Combine similar cross reference types
	-->
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'crossrefs')] and preceding-sibling::x:span[@class='xitem']]">
		<xsl:variable name="precedingType" select="preceding-sibling::x:span[@class='xitem'][1]/descendant::x:span[starts-with(@class,'crossref-type')]"/>
		<xsl:variable name="thisType" select="descendant::x:span[starts-with(@class,'crossref-type')]"/>
		<xsl:if test="$precedingType!=$thisType">
			<xsl:apply-templates select="x:span[starts-with(@class,'crossref-type')]"/>
		</xsl:if>
		<xsl:apply-templates select="x:span[starts-with(@class,'crossref-targets')]"/>
	</xsl:template>
	<xsl:template match="x:span[@class='xitem' and parent::x:span[starts-with(@class,'crossrefs')] and not(preceding-sibling::x:span[@class='xitem'])]">
		<xsl:apply-templates select="x:span[starts-with(@class,'crossref-type')] | x:span[starts-with(@class,'crossref-targets')]"/>
	</xsl:template>
	<xsl:template match="x:span[not(@class)][preceding-sibling::*[1][@class='xitem' and parent::x:span[starts-with(@class,'crossrefs')]] and following-sibling::*]" priority="100">
		<xsl:choose>
			<xsl:when test="following-sibling::*[1][@class='xitem'][descendant::x:span[starts-with(@class,'crossref-type')]]">
				<xsl:variable name="precedingType" select="preceding-sibling::*[1]/descendant::x:span[starts-with(@class,'crossref-type')]"/>
				<xsl:variable name="followingType" select="following-sibling::*[1]/descendant::x:span[starts-with(@class,'crossref-type')]"/>
				<xsl:choose>
					<xsl:when test="$precedingType=$followingType">
						<x:span class="Normal">, </x:span>
					</xsl:when>
					<xsl:otherwise>
						<!--	do not want this now					<xsl:value-of select="."/>-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::*"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="x:span[@class='sharedgrammaticalinfo']">
		<xsl:apply-templates select="x:span[@class='morphosyntaxanalysis']"/>
	</xsl:template>
	<xsl:template match="x:span[@class='sensecontent']">
		<xsl:apply-templates select="x:span[@class='sense' or @class='sense mainentrysubsense']"/>
	</xsl:template>
	<xsl:template match="x:span[@class='referencedentry' or @class='variantformentrybackref']">
		<span class="Variant_Form" lang="{x:span/x:span/@lang}">
			<xsl:call-template name="DoFormWithHomographNumber"/>
		</span>
	</xsl:template>
	<xsl:template name="DoFormWithHomographNumber">
		<xsl:choose>
			<xsl:when test="count(descendant-or-self::x:a)=2">
				<!-- have a form and its homograph number -->
				<xsl:apply-templates select="descendant-or-self::x:a[1]"/>
				<xsl:for-each select="descendant-or-self::x:span[x:a][2]">
					<!-- need to avoid any whitespace between the two items so that the homograph 
						number shows up immediately after the form -->
					<a>
<!--						<xsl:copy-of select="@*"/>-->
						<xsl:apply-templates select="@*"/>
						<xsl:copy-of select="x:a/@href"/>
						<xsl:value-of select="x:a"/>
					</a>
				</xsl:for-each>
				<!--					<xsl:apply-templates select="descendant-or-self::x:span[x:a][2]"/>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="descendant-or-self::x:a"/>
			</xsl:otherwise>
		</xsl:choose>
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
	<xsl:template name="GetNonColorItemsFromStyleContent">
		<xsl:param name="sStyle"/>
		<xsl:variable name="sNewList" select="normalize-space($sStyle)"/>
		<xsl:variable name="sFirst" select="substring-before($sNewList,';')"/>
		<xsl:variable name="sRest" select="substring-after($sNewList,';')"/>
		<xsl:if test="string-length($sFirst) &gt; 0">
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
	basic copy template 
-->
	<xsl:template match="node() | @*" priority="0">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="node() | @*" priority="0" mode="HomographNumber">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<!-- 
	Items to ignore 
-->
	<xsl:template match="x:span[starts-with(@class,'sensenumber')]"/>
	<xsl:template match="x:span[starts-with(@class,'xsensenumber')]"/>
	<xsl:template match="x:span[@class='LexEntry-publishStemPara-HomographNumber']"/>
	<xsl:template match="x:span[@class='LexSense-publishStem-Altura--de--la--imagen']"/>
</xsl:stylesheet>
