<?xml version="1.0" encoding="UTF-8"?>
<!-- Версия для работы с РАБИС-НП, 2.5.1 от 19-12-2011
	XSLT для вывода справок

2016-06-29 Dmitrii Evdokimov <diev@mail.ru>:
	добавлены PacketEID и ED275 согласно "УФЭБС. Обмен с клиентами Банка России"
	(http://cbr.ru/analytics/formats/UFEBS_v2016_3_1.zip)
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:ed="urn:cbr-ru:ed:v2.0"
xmlns:env="http://www.w3.org/2003/05/soap-envelope"
xmlns:props="urn:cbr-ru:msg:props:v1.3"
xmlns:sen="urn:cbr-ru:dsig:env:v1.1"
xmlns:dsig="urn:cbr-ru:dsig:v1.1"
xmlns:xf="http://www.w3.org/2002/08/xquery-functions"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:usr="urn:user-functions">

<xsl:output method="text" media-type="text/plain" encoding="WINDOWS-1251" indent="yes"/>

<xsl:template match="/">
	<xsl:apply-templates select="ed:PacketEPD"/>
	<xsl:apply-templates select="ed:PacketESID"/>
	<xsl:apply-templates select="ed:PacketEID"/>
	<xsl:apply-templates select="ed:ED101"/>
	<xsl:apply-templates select="ed:ED103"/>
	<xsl:apply-templates select="ed:ED104"/>
	<xsl:apply-templates select="ed:ED105"/>
	<xsl:apply-templates select="ed:ED110"/>
	<xsl:apply-templates select="ed:ED201"/>
	<xsl:apply-templates select="ed:ED202"/>
	<xsl:apply-templates select="ed:ED203"/>
	<xsl:apply-templates select="ed:ED204"/>
	<xsl:apply-templates select="ed:ED205"/>
	<xsl:apply-templates select="ed:ED206"/>
	<xsl:apply-templates select="ed:ED207"/>
	<xsl:apply-templates select="ed:ED208"/>
	<xsl:apply-templates select="ed:ED209"/>
	<xsl:apply-templates select="ed:ED210"/>
	<xsl:apply-templates select="ed:ED211"/>
	<xsl:apply-templates select="ed:ED214"/>
	<xsl:apply-templates select="ed:ED215"/>
	<xsl:apply-templates select="ed:ED217"/>
	<xsl:apply-templates select="ed:ED218"/>
	<xsl:apply-templates select="ed:ED219"/>
	<xsl:apply-templates select="ed:ED220"/>
	<xsl:apply-templates select="ed:ED221"/>
	<xsl:apply-templates select="ed:ED222"/>
	<xsl:apply-templates select="ed:ED230"/>
	<xsl:apply-templates select="ed:ED240"/>
	<xsl:apply-templates select="ed:ED241"/>
	<xsl:apply-templates select="ed:ED242"/>
	<xsl:apply-templates select="ed:ED243"/>
	<xsl:apply-templates select="ed:ED244"/>
	<xsl:apply-templates select="ed:ED275"/>
	<xsl:apply-templates select="ed:ED301"/>
	<xsl:apply-templates select="ed:ED306"/>
	<xsl:apply-templates select="ed:ED330"/>
	<xsl:apply-templates select="ed:ED331"/>
	<xsl:apply-templates select="ed:ED332"/>
	<xsl:apply-templates select="ed:ED333"/>
	<xsl:apply-templates select="ed:ED373"/>
	<xsl:apply-templates select="ed:ED374"/>
	<xsl:apply-templates select="ed:ED375"/>
	<xsl:apply-templates select="ed:ED378"/>
	<xsl:apply-templates select="ed:ED379"/>
	<xsl:apply-templates select="ed:ED380"/>
	<xsl:apply-templates select="ed:ED381"/>
	<xsl:apply-templates select="ed:ED382"/>
	<xsl:apply-templates select="ed:ED383"/>
	<xsl:apply-templates select="ed:ED385"/>
	<xsl:apply-templates select="ed:ED501"/>
	<xsl:apply-templates select="ed:ED999"/>
</xsl:template>


<!-- =============================================================================================================
	Пакет ЭПД
================================================================================================================== -->
<xsl:template match="ed:PacketEPD">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>ПАКЕТ ЭПД</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@EDQuantity != ''">
	<xsl:text>Количество ЭПД в пакете    : </xsl:text><xsl:value-of select="@EDQuantity"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@Sum != ''">
	<xsl:text>Общая сумма ЭПД в пакете   : </xsl:text>
	<xsl:for-each select="@Sum">
		<xsl:call-template name="fsum"/>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:text>Признак системы обработки  : </xsl:text>
	<xsl:value-of select="@SystemCode			"/>
	<xsl:if test="@SystemCode = 01"><xsl:text> (непрерывная)</xsl:text></xsl:if>
	<xsl:if test="@SystemCode = 02"><xsl:text> (дискретная)</xsl:text></xsl:if>
	<xsl:if test="@SystemCode = 05"><xsl:text> (БЭСП)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Содержит : </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>  №     Тип  ВО    №     Дата        УИС      №     Дата                  П Л А Т Е Л Ь Щ И К                                                      П О Л У Ч А Т Е Л Ь</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> п/п     ЭД       ЭД      ЭД         ЭД       РД     РД        БИК             КС                   ЛС                   СУММА         БИК             КС                   ЛС</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates/>
</xsl:template>

<!-- =============================================================================================================
	Пакет ЭСИД
================================================================================================================== -->
<xsl:template match="ed:PacketESID">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>ПАКЕТ ЭСИД</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:choose>
	<xsl:when test="@EDCreationTime">
			<xsl:text>  Время составления ЭД : </xsl:text>
			<xsl:value-of select="@EDCreationTime"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>Содержит: </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:InitialPacketED/@EDNo != ''">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Идентификаторы исходного пакета ЭПД : </xsl:text>
	<xsl:text>№ </xsl:text><xsl:value-of select="ed:InitialPacketED/@EDNo"/>
	<xsl:text> от </xsl:text>
	<xsl:for-each select="ed:InitialPacketED/@EDDate">
			<xsl:call-template name="date"/>
	</xsl:for-each>
	<xsl:text> УИС : </xsl:text><xsl:value-of select="ed:InitialPacketED/@EDAuthor"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:apply-templates/>
</xsl:template>

<!-- =============================================================================================================
	Пакет информационных ЭС
================================================================================================================== -->
<xsl:template match="ed:PacketEID">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>ПАКЕТ ИНФОРМАЦИОННЫХ ЭС</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:choose>
		<xsl:when test="@EDCreationTime">
			<xsl:text>Время составления ЭС : </xsl:text>
			<xsl:value-of select="@EDCreationTime"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="count(ed:ED208)!=0">
		<xsl:text>Принято                : </xsl:text>
		<xsl:value-of select="count(ed:ED208[@ResultCode = 1])"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Передано получателю    : </xsl:text>
		<xsl:value-of select="count(ed:ED208[@ResultCode = 2])"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Не передано получателю : </xsl:text>
		<xsl:value-of select="count(ed:ED208[@ResultCode = 3])"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:text>Содержит: </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates/>
</xsl:template>

<!-- =============================================================================================================
	Э П Д
================================================================================================================== -->
<!-- ED101 -->
<xsl:template match="ed:ED101">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>

	<xsl:text>  </xsl:text>
	<xsl:text>ED101</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
	<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:Payer">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
		<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:Payee">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
	<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!-- ED102 -->
<xsl:template match="ed:ED102">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:text>  </xsl:text>
	<xsl:text>ED102</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
	<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:Payer">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank"><xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:Payee">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank"><xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!-- ED103 -->
<xsl:template match="ed:ED103">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:text>  </xsl:text>
	<xsl:text>ED103</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
		<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
		<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:Payer">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
	<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:Payee">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
	<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!-- ED104 -->
<xsl:template match="ed:ED104">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:text>  </xsl:text>
	<xsl:text>ED104</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
	<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:Payer">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
	<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:Payee">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
	<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
	<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!-- ED105 -->
<xsl:template match="ed:ED105">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:text>  </xsl:text>
	<xsl:text>ED105</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
			<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
			<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:Payer">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
			<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
			</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
			<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:Payee">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
			<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
			</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
			<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="ed:ED110">
	<xsl:choose>
	<xsl:when test="contains(name(..),'PacketEPD')">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(position()-$modif_pos)),position()-$modif_pos)"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:text>  </xsl:text>
	<xsl:text>ED110</xsl:text>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@TransKind"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDNo">
	<xsl:value-of select="concat(substring('      ',1,6-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:value-of select="@EDAuthor"/>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocNo">
	<xsl:value-of select="concat(substring('   ',1,3-string-length(current())),current())"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:for-each select="ed:PayerBrf">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
			<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
			</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
			<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:for-each select="ed:PayeeBrf">
	<xsl:text> </xsl:text>
	<xsl:for-each select="ed:Bank">
			<xsl:for-each select="@BIC"><xsl:value-of select="."/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:choose>
			<xsl:when test="@CorrespAcc"><xsl:value-of select="@CorrespAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
			</xsl:choose>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
			<xsl:when test="@PersonalAcc"><xsl:value-of select="@PersonalAcc"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('                    ','')"/></xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>
<!-- =========================================================================
			Э С И Д
	=========================================================================
-->
<!--  ED201  -->
<xsl:template match="ed:ED201">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О РЕЗУЛЬТАТАХ КОНТРОЛЯ ЭД (ПАКЕТА ЭД)/ED201/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>Время проведения контроля    : </xsl:text><xsl:value-of select="@CtrlTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Код результата контроля      : </xsl:text><xsl:value-of select="@CtrlCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Текст пояснения              : </xsl:text><xsl:value-of select="ed:Annotation"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:ErrorDiagnostic != ''">
	<xsl:text>Детальная диагностика ошибки : </xsl:text><xsl:value-of select="ed:ErrorDiagnostic"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:MsgID != ''">
	<xsl:text>Транспортный идентификатор сообщения : </xsl:text><xsl:value-of select="ed:MsgID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED202  -->
<xsl:template match="ed:ED202">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ПО ЭПД (ПАКЕТУ ЭПД)/ED202/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>Код запроса по ЭПД (пакету ЭПД) : </xsl:text><xsl:value-of select="@EDInquiryCode"/>
	<xsl:if test="@EDInquiryCode = 1"><xsl:text> (Статус ЭПД/результат контроля ЭПД)</xsl:text></xsl:if>
	<xsl:if test="@EDInquiryCode = 2"><xsl:text> (Копия полей ЭПД)</xsl:text></xsl:if>
	<xsl:if test="@EDInquiryCode = 3"><xsl:text> (Результат контроля пакета ЭПД)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED203  -->
<xsl:template match="ed:ED203">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ПО ГРУППЕ ЭПД /ED203/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@Acc != ''">
	<xsl:text>Номер счета по которому производится запрос : </xsl:text><xsl:value-of select="@Acc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:text>Код статуса ЭПД           : </xsl:text><xsl:value-of select="@StatusCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Код запроса по группе ЭПД : </xsl:text><xsl:value-of select="@GroupInquiryCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED204  -->
<xsl:template match="ed:ED204">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ОБ ОТЗЫВЕ ЭПД (ПАКЕТА ЭПД) /ED204/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>Код операции по отзыву : </xsl:text><xsl:value-of select="@Code"/>
	<xsl:if test="@Code = 0"><xsl:text> (Отзыв отложенного ЭПД)</xsl:text></xsl:if>
	<xsl:if test="@Code = 1"><xsl:text> (Отзыв пакета ЭПД)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED205  -->
<xsl:template match="ed:ED205">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О СТАТУСЕ ЭПД (ПАКЕТА ЭПД) /ED205/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>Код статуса ЭПД              : </xsl:text><xsl:value-of select="@StatusStateCode"/>
	<xsl:if test="@StatusStateCode = 00"><xsl:text> (оплачен)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 01"><xsl:text> (отложен)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 02"><xsl:text> (помещен в картотеку в УБР)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 03"><xsl:text> (помещен в картотеку в КО)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 04"><xsl:text> (аннулирован)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 06"><xsl:text> (изъят из картотеки по причине полной оплаты частными суммами)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 08"><xsl:text> (отозван из картотеки)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 09"><xsl:text> (оплачен из картотеки)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 10"><xsl:text> (безотзывный)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 11"><xsl:text> (помещен в картотеку документов, ожидающих акцепта)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 12"><xsl:text> (ответные ЭПД в режиме НОП с начала текущего рейса)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 13"><xsl:text> (встречный ЭПД отложен)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 14"><xsl:text> (встречный ЭПД прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 15"><xsl:text> (ожидает подтверждения из системы БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 19"><xsl:text> (прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 20"><xsl:text> (не прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 21"><xsl:text> (пакет ЭПД не прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 30"><xsl:text> (пакет ЭПД прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 31"><xsl:text> (пакет ЭПД аннулирован)</xsl:text></xsl:if>
	<xsl:if test="@StatusStateCode = 32"><xsl:text> (пакет ЭПД не может быть отозван)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="@Balance != ''">
	<xsl:text>Сумма остатка платежа        : </xsl:text>
	<xsl:for-each select="@Balance"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@CtrlCode != ''">
	<xsl:text>Код результата контроля      : </xsl:text><xsl:value-of select="@CtrlCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@CtrlTime != ''">
	<xsl:text>Время проведения контроля ЭД (пакета ЭД) : </xsl:text><xsl:value-of select="@CtrlTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:Annotation != ''">
	<xsl:text>Текст пояснения              : </xsl:text><xsl:value-of select="ed:Annotation"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:ErrorDiagnostic != ''">
	<xsl:text>Детальная диагностика ошибки : </xsl:text><xsl:value-of select="ed:ErrorDiagnostic"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@SessionID != ''">
	<xsl:text>Номера рейса, в котором ЭПД будут обработаны : </xsl:text><xsl:value-of select="@SessionID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>

</xsl:template>

<!--  ED206  -->

<xsl:template match="ed:ED206">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:if test="@DC = 1"><xsl:text>ПОДТВЕРЖДЕНИЕ ДЕБЕТА/ED206/    </xsl:text></xsl:if>
	<xsl:if test="@DC = 2"><xsl:text>ПОДТВЕРЖДЕНИЕ КРЕДИТА/ED206/   </xsl:text></xsl:if>
	<xsl:value-of select="@Acc"/>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>Дата совершения операции   : </xsl:text>
	<xsl:for-each select="@TransDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Время совершения операции  : </xsl:text><xsl:value-of select="@TransTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>БИК банка корреспондента   : </xsl:text><xsl:value-of select="@BICCorr"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Сумма                      : </xsl:text><xsl:value-of select="usr:fSum(@Sum)"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Корреспондирующий счет     : </xsl:text><xsl:value-of select="@CorrAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Реквизиты РД               : </xsl:text><xsl:text>  №: </xsl:text>
	<xsl:value-of select="ed:AccDoc/@AccDocNo"/>
	<xsl:text>  Дата выписки : </xsl:text>
	<xsl:for-each select="ed:AccDoc/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED207  -->
<xsl:template match="ed:ED207">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О ГРУППЕ ЭПД /ED207/  </xsl:text>
	<xsl:if test="@StatusCode = 03"><xsl:text>  ЭПД ПОМЕЩЕН В КАРТОТЕКУ КО</xsl:text></xsl:if>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@QuantityED != ''"><xsl:text>Количество ЭПД  : </xsl:text><xsl:value-of select="@QuantityED"/></xsl:if>
	<xsl:if test="@Sum != ''">
	<xsl:text>  Сумма : </xsl:text><xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
	</xsl:if>
	<xsl:if test="@EDDayNo != ''">   <xsl:text>  Номер ЭСИД      : </xsl:text><xsl:value-of select="@EDDayNo"/></xsl:if>
	<xsl:if test="@MessageNo != ''"> <xsl:text>  Номер сообщения : </xsl:text><xsl:value-of select="@MessageNo"/></xsl:if>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
	<xsl:if test="@QuantityED != ''">
	<xsl:for-each select="ed:EDInfo">
			<xsl:value-of select="concat('   ',position(),'.  ')"/>
			<xsl:text> </xsl:text>
			<xsl:for-each select="@FileDate"><xsl:call-template name="date"/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
			<xsl:text> </xsl:text>
			<xsl:if test="ed:EDRefID/@EDNo != ''">
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:apply-templates select="ed:EDRefID"/>
			</xsl:if>
	</xsl:for-each>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED208  -->
<xsl:template match="ed:ED208">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИНФОРМАЦИЯ О СОСТОЯНИИ ЭС /ED208/ </xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>Код результата обработки ЭД  : </xsl:text>
	<xsl:value-of select="@ResultCode"/>
	<xsl:if test="@ResultCode = 1"><xsl:text> (ЭД принят)</xsl:text></xsl:if>
	<xsl:if test="@ResultCode = 2"><xsl:text> (ЭД передан получателю)</xsl:text></xsl:if>
	<xsl:if test="@ResultCode = 3"><xsl:text> (ЭД не доставлен получателю)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="@CtrlCode != ''">
	<xsl:text>Код результата контроля      : </xsl:text><xsl:value-of select="@CtrlCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:Annotation != ''">
	<xsl:text>Текст пояснения              : </xsl:text><xsl:value-of select="ed:Annotation"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED209  -->
<xsl:template match="ed:ED209">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>ИЗВЕЩЕНИЕ О РЕЖИМЕ ОБМЕНА/РАБОТЫ СЧЕТА /ED209/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text> Код режима               : </xsl:text> <xsl:value-of select="@OperatingModeCode"/> <xsl:text> - </xsl:text>
	<xsl:if test="@OperatingModeCode = 00"><xsl:text> (начало участия в обмене ЭД)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 01"><xsl:text> (приостановление участия в обмене ЭД по инициативе УБР)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 02"><xsl:text> (приостановление участия в обмене ЭД по инициативе участника)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 03"><xsl:text> (отключение от участия в обмене ЭД)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 04"><xsl:text> (установлен арест счета на проведение расчетов)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 05"><xsl:text> (установлен арест счета на дебетование)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 06"><xsl:text> (установлен арест счета на кредитование)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 07"><xsl:text> (снят арест счета,установленный ранее)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 08"><xsl:text> (свободный режим)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 09"><xsl:text> (режим картотеки)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 10"><xsl:text> (приостановление участия в непрерывной обработке платежей)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 11"><xsl:text> (возобновление участия в непрерывной обработке платежей)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 12"><xsl:text> (регистрация КО в БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 13"><xsl:text> (полное ограничение участия в расчетах в системе БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 14"><xsl:text> (частичное ограничение участия в расчетах в системе БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 17"><xsl:text> (отмена временных ограничений и временного отключения)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 18"><xsl:text> (исключение из расчетов в системе БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 19"><xsl:text> (регистрация клиента как АУР системы БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 20"><xsl:text> (исключение клиента из АУР)</xsl:text></xsl:if>
	<xsl:if test="@OperatingModeCode = 21"><xsl:text> (изменены дополнительные условия проведения платежей)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> Дата установления режима : </xsl:text>
	<xsl:for-each select="@BeginDate"> <xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="@EndDate">
			<xsl:text> Дата окончания режима    : </xsl:text>
			<xsl:for-each select="@EndDate"><xsl:call-template name="date"/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:text> БИК КО/УБР, меняющего режим работы : </xsl:text><xsl:value-of select="@BIC"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="@Acc">
		<xsl:text> Номер счета, по которому формируется ЭСИД : </xsl:text>
		<xsl:for-each select="@Acc"><xsl:value-of select="."/></xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@ed:Annotation">
		<xsl:text> Текст пояснения : </xsl:text>
		<xsl:for-each select="ed:Annotation"><xsl:value-of select="."/></xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
</xsl:template>


<!--  ED210  -->
<xsl:template match="ed:ED210">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ВЫПИСКИ ИЗ ЛИЦЕВОГО СЧЕТА /ED210/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@Acc != ''">
	<xsl:text>Номер счета, по которому производится запрос : </xsl:text><xsl:value-of select="@Acc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:text>Код запроса выписки: </xsl:text><xsl:value-of select="@AbstractRequest"/>
	<xsl:if test="@AbstractRequest=1"><xsl:text>   (Промежуточная выписка)</xsl:text></xsl:if>
	<xsl:if test="@AbstractRequest=2"><xsl:text>   (Текущий остаток на счете)</xsl:text></xsl:if>
	<xsl:if test="@AbstractRequest=3"><xsl:text>   (Свернутая выписка)</xsl:text></xsl:if>
	<xsl:if test="@AbstractRequest=4"><xsl:text>   (Отчет для выверки документов дня участников)</xsl:text></xsl:if>
	<xsl:if test="@AbstractRequest=5"><xsl:text>   (Извещение о задолженности по внутридневному кредиту)</xsl:text></xsl:if>
	<xsl:if test="@AbstractRequest=6"><xsl:text>   (Отчет для выверки документов дня ПУР в системе БЭСП)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Дата, на которую формируется выписка : </xsl:text>
	<xsl:for-each select="@AbstractDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="@BeginTime != ''">
	<xsl:text>Начало периода формирования выписки  : </xsl:text>
	<xsl:for-each select="@BeginTime"><xsl:value-of select="current()"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@EndTime != ''">
	<xsl:text>Конец периода формирования выписки   : </xsl:text>
	<xsl:for-each select="@EndTime"><xsl:value-of select="current()"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED211  -->
<xsl:template match="ed:ED211">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:if test="@AbstractKind = 0"><xsl:text>ОКОНЧАТЕЛЬНАЯ ВЫПИСКА /ED211/</xsl:text></xsl:if>
	<xsl:if test="@AbstractKind = 1"><xsl:text>ПРОМЕЖУТОЧНАЯ ВЫПИСКА /ED211/</xsl:text></xsl:if>
	<xsl:if test="@AbstractKind = 2"><xsl:text>ТЕКУЩИЙ ОСТАТОК НА СЧЕТЕ /ED211/</xsl:text></xsl:if>
	<xsl:if test="@AbstractKind = 3"><xsl:text>СВЕРНУТАЯ ВЫПИСКА /ED211/</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>Сумма ЭПД АУР, направленных в ЦОиР и ожидающих подтверждения из ЦОиР: </xsl:text>
	<xsl:value-of select="usr:fSum(@RTGSUnconfirmedED)"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>Период формирования выписки: </xsl:text>
	<xsl:for-each select="@EndTime"><xsl:call-template name="UTC2MoscowTime"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>------------------------------------------------------------------------------------------------------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>БИК </xsl:text><xsl:value-of select="@InfoBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="@InfoRKC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>                                                     ЛИЦЕВОЙ СЧЕТ&#13;&#10;</xsl:text>
	<xsl:value-of select="concat('                                      ','')"/><xsl:value-of select="@InfoBANK"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>                                                     ЗА </xsl:text>
	<xsl:for-each select="@AbstractDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>                                             ДПД </xsl:text>
	<xsl:for-each select="@LastMovetDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>СЧЕТ </xsl:text><xsl:value-of select="@Acc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>ВХОДЯЩИЙ ОСТАТОК Пассив                                                                          </xsl:text>
	<xsl:for-each select="@EnterBal"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<!--     -->
	<xsl:if test="@AbstractKind = 0">
	<xsl:text>------------------------------------------------------------------------------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>    №    |ВО|БИК БАНКА|КОРР.|        СЧЕТ        |        СЧЕТ        |ПР|         ДЕБЕТ        |        КРЕДИТ        |  №   &#13;&#10;</xsl:text>
	<xsl:text>   ДОК   |  |  КОРР.  |СЧЕТ |    ОТПРАВИТЕЛЯ/    |     ПОЛУЧАТЕЛЯ     |ЗО|                      |                      |СТРО- &#13;&#10;</xsl:text>
	<xsl:text>         |  |         |     |    ПЛАТЕЛЬЩИКА     |                    |  |                      |                      | КИ   &#13;&#10;</xsl:text>
	<xsl:text>------------------------------------------------------------------------------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>    1    |2 |    3    |  4  |         5          |         6          |7 |           8          |           9          |  10  &#13;&#10;</xsl:text>
	<xsl:text>------------------------------------------------------------------------------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:for-each select="ed:TransInfo">
		<xsl:choose>
			<xsl:when test="@AccDocNo">
				<xsl:for-each select="@AccDocNo">
					<xsl:value-of select="concat(substring('         ',1,9-string-length(current())),current())"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise><xsl:text>&#32;&#32;&#32;&#32;&#32;&#32;&#32;&#32;&#32;</xsl:text></xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>

		<xsl:value-of select="@TransKind"/>
		<xsl:text> </xsl:text>

		<xsl:value-of select="@BICCorr"/>
		<xsl:text> </xsl:text>

		<xsl:choose>
			<xsl:when test="@CorrAccBrf">
				<xsl:for-each select="@CorrAccBrf">
					<xsl:value-of select="concat(substring('   ',1,5-string-length(current())),current())"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('     ','')"/></xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>

		<xsl:value-of select="@PayerPersonalAcc"/>
		<xsl:text> </xsl:text>

		<xsl:value-of select="@PayeePersonalAcc"/>
		<xsl:text> </xsl:text>

		<xsl:if test="@TurnoverKind  = 2">ЗО</xsl:if>
		<xsl:if test="@TurnoverKind  != 2"><xsl:text>&#32;&#32;</xsl:text></xsl:if>
		<xsl:text> </xsl:text>

		<xsl:if test="@DC = 2">
			<xsl:value-of select="concat('                       ','')"/>
			<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
		</xsl:if>
		<xsl:if test="@DC = 1">
			<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
			<xsl:value-of select="concat('                       ','')"/>
		</xsl:if>
		<xsl:text> </xsl:text>

		<xsl:value-of select="concat(substring('      ',1,6-string-length(position())),position())"/>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>------------------------------------------------------------------------------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>ИТОГО ОБОРОТЫ                                                             </xsl:text>
	<xsl:for-each select="@DebetSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:for-each select="@CreditSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> &#13;&#10;</xsl:text>

	<xsl:text>ИСХОДЯЩИЙ ОСТАТОК Пассив                                                                         </xsl:text>
	<xsl:for-each select="@OutBal"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED214  -->
<xsl:template match="ed:ED214">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ ОБ АКЦЕПТЕ /ED214/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:for-each select="@AcptCode">
	<xsl:text>Код акцепта                    : </xsl:text><xsl:value-of select="."/>
	<xsl:if test="@AcptCode = 0"> (согласие на полный акцепт)</xsl:if>
	<xsl:if test="@AcptCode = 1"> (частичный отказ от акцепта)</xsl:if>
	<xsl:if test="@AcptCode = 2"> (полный отказ от акцепта)</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@AcptSum">
	<xsl:text>Сумма, предъявленная к акцепту : </xsl:text><xsl:call-template name="sum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@AcptDenialSum">
	<xsl:text>Сумма отказа от акцепта        : </xsl:text><xsl:call-template name="sum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="ed:Violation">
	<xsl:text>Характер нарушения             : </xsl:text><xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>


<!--  ED215  -->
<xsl:template match="ed:ED215">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЭСИД С КОПИЕЙ ПОЛЕЙ ЭПД /ED215/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:if test="@StatusCode != ''">
	<xsl:text>Код статуса ЭПД : </xsl:text><xsl:value-of select="@StatusCode"/>
	<xsl:if test="@StatusCode = 00"><xsl:text> (оплачен)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 01"><xsl:text> (отложен)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 02"><xsl:text> (помещен в картотеку в УБР)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 03"><xsl:text> (помещен в картотеку в КО)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 04"><xsl:text> (аннулирован)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 06"><xsl:text> (изъят из картотеки по причине полной оплаты частными суммами)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 08"><xsl:text> (отозван из картотеки)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 09"><xsl:text> (оплачен из картотеки)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 10"><xsl:text> (безотзывный)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 11"><xsl:text> (помещен в картотеку документов, ожидающих акцепта)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 12"><xsl:text> (ответные ЭПД в режиме НОП с начала текущего рейса)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 13"><xsl:text> (встречный ЭПД отложен)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 14"><xsl:text> (встречный ЭПД прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 15"><xsl:text> (ожидает подтверждения из системы БЭСП)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 19"><xsl:text> (прошел контроль)</xsl:text></xsl:if>
	<xsl:if test="@StatusCode = 20"><xsl:text> (не прошел контроль)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@QuantityED != ''">
			<xsl:text>Количество ЭПД в группе  : </xsl:text><xsl:value-of select="@QuantityED"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@Sum != ''">
			<xsl:text>Общая сумма ЭПД в группе : </xsl:text>
			<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:choose> <xsl:when test="ed:PartInfo">
			<xsl:apply-templates select="ed:PartInfo"/>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:choose>
	<xsl:when test="ed:EDCopy">
			<xsl:text>  №     Код    Тип  ВО    №     Дата        УИС      №     Дата                  П Л А Т Е Л Ь Щ И К                                                      П О Л У Ч А Т Е Л Ь</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text> п/п   ошибки   ЭД       ЭД      ЭД         ЭД       РД     РД        БИК             КС                   ЛС                   СУММА               БИК             КС                   ЛС</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>

			<xsl:for-each select="ed:EDCopy">
			<xsl:value-of select="concat(substring('      ',1,6-string-length(position())),position())"/>
			<xsl:text> </xsl:text>
			<xsl:choose>
					<xsl:when test="@CtrlCode">
					<xsl:text> </xsl:text>
					<xsl:value-of select="@CtrlCode"/>
					<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:otherwise><xsl:text>   -  </xsl:text></xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
			</xsl:for-each>
	</xsl:when>
	</xsl:choose>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED217  -->
<xsl:template match="ed:ED217">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О ЗАДОЛЖЕННОСТИ ПО ВНУТРИДНЕВНОМУ КРЕДИТУ /ED217/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:for-each select="@InfoDate">
	<xsl:text>Дата составления информации      : </xsl:text><xsl:call-template name="date"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>БИК банка :  </xsl:text>
	<xsl:for-each select="@BIC">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Корреспондентский счет (субсчет) :  </xsl:text>
	<xsl:for-each select="@CorrespAcc">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:choose>
	<xsl:when test="ed:CreditInfo">
			<xsl:for-each select="ed:CreditInfo">
			<xsl:if test="@SessionID != ''">
					<xsl:text>Номер рейса :  </xsl:text>
					<xsl:for-each select="@SessionID"><xsl:value-of select="."/><xsl:text>&#13;&#10;</xsl:text></xsl:for-each>
			</xsl:if>
			<xsl:text>Признак предоставления/погашения внутридневного кредита :  </xsl:text>
			<xsl:for-each select="@CreditOperation"><xsl:value-of select="."/><xsl:text>&#13;&#10;</xsl:text></xsl:for-each>
			<xsl:text>Текущий размер лимита внутридневного кредита и кредита овернайт :  </xsl:text>
			<xsl:for-each select="@CreditLimit">
					<xsl:value-of select="."/>
					<xsl:text>&#13;&#10;</xsl:text>
			</xsl:for-each>
			<xsl:if test="@EndTime != ''">
					<xsl:text>Конец периода формирования выписки :  </xsl:text>
					<xsl:for-each select="@EndTime">
					<xsl:value-of select="."/>
					<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>
			</xsl:if>
			<xsl:if test="@DebtBefore != ''">
					<xsl:text>Сумма задолженности по предоставленному внутридневному кредиту до исполнения документа    :  </xsl:text>
					<xsl:for-each select="@DebtBefore"><xsl:call-template name="sum"/></xsl:for-each>
					<xsl:text>&#13;&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="@DebtAfter != ''">
					<xsl:text>Сумма задолженности по предоставленному внутридневному кредиту после исполнения документа :  </xsl:text>
					<xsl:for-each select="@DebtAfter"><xsl:call-template name="sum"/></xsl:for-each>
					<xsl:text>&#13;&#10;</xsl:text>
			</xsl:if>
			<xsl:for-each select="ed:AccDocInfo">
					<xsl:if test="@AccDocNo != ''">
					<xsl:text>Номер расчетного документа        :  </xsl:text>
					<xsl:for-each select="@AccDocNo"><xsl:value-of select="."/></xsl:for-each>
					<xsl:text>&#13;&#10;</xsl:text>
					</xsl:if>
					<xsl:text>Дата выписки расчетного документа :  </xsl:text>
					<xsl:for-each select="@AccDocDate"><xsl:call-template name="date"/>
					<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>
					<xsl:text>Сумма ЭПД :  </xsl:text>
					<xsl:for-each select="@Sum">
					<xsl:call-template name="sum"/>
					<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>
					<xsl:if test="@CashDocNo != ''">
					<xsl:text>Номер кассового документа         :  </xsl:text>
					<xsl:for-each select="@CashDocNo">
							<xsl:value-of select="."/>
							<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>
					</xsl:if>
			</xsl:for-each>
			</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
			<xsl:text> </xsl:text>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED218  -->
<xsl:template match="ed:ED218">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ФОРМЫ ИЗ АРХИВА /ED218/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@ReportID != ''">
	<xsl:text>Идентификатор (номер) формы               : </xsl:text><xsl:value-of select="@ReportID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:text>Дата, за которую запрашивается информация : </xsl:text>
	<xsl:for-each select="@ReportDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!--  ED219  -->
<xsl:template match="ed:ED219">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ВЫХОДНАЯ ФОРМА /ED219/ </xsl:text>
	<xsl:if test="@EDReportID != ''">
	<xsl:value-of select="@EDReportID"/>
	</xsl:if>
	<xsl:text> НА </xsl:text>
	<xsl:for-each select="@ReportDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
	<xsl:for-each select="ed:ReportContent"><xsl:value-of select="current()"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED220  -->
<xsl:template match="ed:ED220">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС НА ПОЛУЧЕНИЕ ОТВЕТНОГО ДОКУМЕНТООБОРОТА /ED220/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>Период запроса ЭД : </xsl:text>
	<xsl:if test="@InquiryPeriodCode=1"><xsl:text>Запрос новых ЭД в адрес участника с момента последнего запроса</xsl:text></xsl:if>
	<xsl:if test="@InquiryPeriodCode=2"><xsl:text>Запрос всех ЭД в адрес участника за указанную дату</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Категория ЭД      : </xsl:text>
	<xsl:if test="@EDTypeCode=1"><xsl:text>ЭПД</xsl:text></xsl:if>
	<xsl:if test="@EDTypeCode=2"><xsl:text>ЭСИД</xsl:text></xsl:if>
	<xsl:if test="@EDTypeCode=3"><xsl:text>все ЭД</xsl:text></xsl:if>

	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="@InquiryDate != ''">
	<xsl:text>Дата, за которую запрашивается ЭД : </xsl:text>
	<xsl:for-each select="@InquiryDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED221  -->
<xsl:template match="ed:ED221">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ОТЧЕТ ОБ ОПЕРАЦИЯХ ПО СЧЕТУ ДЛЯ ВЫВЕРКИ ДОКУМЕНТОВ ДНЯ УЧАСТНИКОВ /ED221/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@ExcludedEDQuantity > 0">
	<xsl:text>Количество исключенных документов по счету участников  : </xsl:text>
	<xsl:value-of select="@ExcludedEDQuantity"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@ExcludedEDSum > 0">
	<xsl:text>Общая сумма исключенных документов по счету участников : </xsl:text>
	<xsl:for-each select="@ExcludedEDSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@CreditQuantity > 0">
	<xsl:text>Количество документов по кредиту счета участников      : </xsl:text>
	<xsl:value-of select="@CreditQuantity"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@CreditSum > 0">
	<xsl:text>Общая сумма документов по кредиту счета участников     : </xsl:text>
	<xsl:for-each select="@CreditSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@DebetQuantity > 0">
	<xsl:text>Количество документов по дебету счета участников       : </xsl:text>
	<xsl:value-of select="@DebetQuantity"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@DebetSum > 0">
	<xsl:text>Общая сумма документов по дебету счета участников      : </xsl:text>
	<xsl:for-each select="@DebetSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@CreditLimitSum > 0">
	<xsl:text>Сумма лимита внутридневного кредита    : </xsl:text>
	<xsl:for-each select="@CreditLimitSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@ReservedSum > 0">
	<xsl:text>Сумма забронированных средств          : </xsl:text>
	<xsl:for-each select="@ReservedSum"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:text>Исходящий остаток на счете участника   : </xsl:text>
	<xsl:for-each select="@OutBal"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Входящий остаток на счете участника    : </xsl:text>
	<xsl:for-each select="@EnterBal"><xsl:call-template name="sum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Номер счета, по которому формируется ЭСИД : </xsl:text>
	<xsl:value-of select="@Acc"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Дата, на которую формируется выписка      : </xsl:text>
	<xsl:for-each select="@AbstractDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Конец периода формирования выписки        : </xsl:text>
	<xsl:value-of select="@EndTime"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Дата совершения операций по счету         : </xsl:text>
	<xsl:for-each select="@TransDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:choose> <xsl:when test="ed:EDCopyBrf">
	<xsl:for-each select="ed:EDCopyBrf">
			<xsl:text>Информация (копия ключевых полей) об ЭПД</xsl:text>
			<xsl:text>&#13;&#10;&#10;</xsl:text>
			<xsl:if test="@CtrlCode != ''">
			<xsl:text>Код результата контроля : </xsl:text><xsl:value-of select="@CtrlCode"/>
			<xsl:text>&#13;&#10;</xsl:text>
			</xsl:if>
			<xsl:text>Сумма    : </xsl:text>
			<xsl:for-each select="@Sum"><xsl:call-template name="sum"/></xsl:for-each>
			<xsl:if test="ed:EDRefID/@EDNo != ''">
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:apply-templates select="ed:EDRefID"/>
			</xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:when> </xsl:choose>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="ed:EDCopy">

			<xsl:text>  №     Код    Тип  ВО    №     Дата        УИС      №     Дата                  П Л А Т Е Л Ь Щ И К                                                      П О Л У Ч А Т Е Л Ь</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text> п/п   ошибки   ЭД       ЭД      ЭД         ЭД       РД     РД        БИК             КС                   ЛС                   СУММА            БИК             КС                   ЛС</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>

			<xsl:for-each select="ed:EDCopy">
			<xsl:value-of select="concat(substring('      ',1,6-string-length(position())),position())"/>
			<xsl:text> </xsl:text>
			<xsl:choose>
					<xsl:when test="@CtrlCode">
					<xsl:text> </xsl:text>
					<xsl:value-of select="@CtrlCode"/>
					<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:otherwise><xsl:text>  -   </xsl:text></xsl:otherwise>
			</xsl:choose>

			<xsl:apply-templates/>

			</xsl:for-each>
	</xsl:when>
	</xsl:choose>

</xsl:template>

<!--  ED222  -->
<xsl:template match="ed:ED222">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О ДЕБЕТЕ/КРЕДИТЕ ДЛЯ КАССОВЫХ ДОКУМЕНТОВ /ED222/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>БИК УБР                   :  </xsl:text>
	<xsl:for-each select="@BIC">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Номер кассового документа :  </xsl:text>
	<xsl:for-each select="@CashDocNo">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Дата кассового документа  :  </xsl:text>
	<xsl:for-each select="@CashDocDate">
	<xsl:call-template name="date"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Лицевой счет кассы (балансовый счет 20201) :  </xsl:text>
	<xsl:for-each select="@CashAcc">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Признак дебета/кредита по отношению к лицевому счету кассы :  </xsl:text>
	<xsl:for-each select="@CashDC">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Общая сумма документа     :  </xsl:text>
	<xsl:for-each select="@Sum">
	<xsl:call-template name="sum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Счет, корреспондирующий со счетом кассы :  </xsl:text>
	<xsl:for-each select="@CorrAcc">
	<xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--  ED230  -->
<xsl:template match="ed:ED230">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ДАННЫХ НСИ /ED230/ </xsl:text>
	<xsl:call-template name="PriznGr"/>
</xsl:template>

<!--  ED240  -->
<xsl:template match="ed:ED240">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ИНФОРМАЦИИ О ПЕРЕДАННЫХ/ПОЛУЧЕННЫХ ЭС /ED240/ </xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text> Тип запроса информации : </xsl:text>
	<xsl:for-each select="@ExchangeTypeCode">
	<xsl:value-of select="."/>
	<xsl:if test=".=1"><xsl:text>  (Информация передана из УЭО в УБР(ВЦ)) </xsl:text></xsl:if>
	<xsl:if test=".=2"><xsl:text>  (Информация передана из УБР(ВЦ) в УЭО) </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="@EDTypeNo != ''">
	<xsl:text> Тип ЭС :  </xsl:text><xsl:value-of select="@EDTypeNo"/>
	<xsl:if test="@EDTypeNo =1001"><xsl:text>  (PacketEPD) </xsl:text></xsl:if>
	<xsl:if test="@EDTypeNo =1002"><xsl:text>  (PacketEsid) </xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@SessionID != ''">
	<xsl:text> Номер рейса :  </xsl:text><xsl:value-of select="@SessionID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@InquiryDate != ''">
	<xsl:text> Дата, за которую запрашивается ЭД : </xsl:text>
	<xsl:for-each select="@InquiryDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED241  -->
<xsl:template match="ed:ED241">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИНФОРМАЦИЯ О ПЕРЕДАННЫХ/ПОЛУЧЕННЫХ ЭС /ED241/ </xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:text> Список электронных сообщений </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> ----------------------------- </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:for-each select="ed:EDRequisiteList">
	<xsl:text>№ </xsl:text><xsl:value-of select="@EDNo"/>
	<xsl:text> от </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>  УИС : </xsl:text><xsl:value-of select="@EDAuthor"/>
	<xsl:text>  тип ЭС:  </xsl:text><xsl:value-of select="@EDTypeNo"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="@TransportFileName != ''">
			<xsl:text>Имя файла :  </xsl:text>
			<xsl:for-each select="@TransportFileName"><xsl:value-of select="."/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:text>Время приема/отправки сообщения :  </xsl:text><xsl:value-of select="@EDProcessingTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--  ED242  -->
<xsl:template match="ed:ED242">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС НА ПОВТОРНОЕ ПОЛУЧЕНИЕ СООБЩЕНИЯ /ED242/ </xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>Тип запроса : </xsl:text><xsl:value-of select="@RepeatReceptInqCode"/>
	<xsl:if test="@RepeatReceptInqCode=1"><xsl:text>  (Получение электронного сообщения) </xsl:text></xsl:if>
	<xsl:if test="@RepeatReceptInqCode=2"><xsl:text>  (Получение информации из РПП за конкретный рейс) </xsl:text></xsl:if>
	<xsl:if test="@RepeatReceptInqCode=3"><xsl:text>  (Получение электронных сообщений определенного типа) </xsl:text></xsl:if>
	<xsl:if test="@RepeatReceptInqCode=4"><xsl:text>  (Получение результатов контроля ранее направленного пакета ЭПД) </xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="@EDTypeNo != ''">
	<xsl:text>Тип ЭС      : </xsl:text><xsl:value-of select="@EDTypeNo"/>
	<xsl:if test="@EDTypeNo =1001"><xsl:text>  (PacketEPD) </xsl:text></xsl:if>
	<xsl:if test="@EDTypeNo =1002"><xsl:text>  (PacketEsid) </xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@SystemCode != ''">
	<xsl:text>Признак системы обработки : </xsl:text><xsl:value-of select="@SystemCode"/>
	<xsl:if test="@SystemCode = 01"><xsl:text> (непрерывная)</xsl:text></xsl:if>
	<xsl:if test="@SystemCode = 02"><xsl:text> (дискретная)</xsl:text></xsl:if>
	<xsl:if test="@SystemCode = 05"><xsl:text> (БЭСП)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@SessionID != ''">
	<xsl:text>Номер рейса :  </xsl:text><xsl:value-of select="@SessionID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED243  -->
<xsl:template match="ed:ED243">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС НА ПОЛУЧЕНИЕ ИНФОРМАЦИИ ПО ЭПД УЧАСТНИКА /ED243/ </xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text> Код запроса : </xsl:text><xsl:value-of select="@EDDefineRequestCode"/>
	<xsl:if test="@EDDefineRequestCode = 01">
	<xsl:text> (Уточните номер банковского (лицевого) счета получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 02">
	<xsl:text> (Уточните номер банковского (лицевого) счета получателя и наименование получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 03">
	<xsl:text> (Подтвердите отсутствие дублирования расчетного документа с указанными реквизитами)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 04">
	<xsl:text> (Подтвердите наименование плательщика)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 05">
	<xsl:text> (Подтвердите наименование получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 06">
	<xsl:text> (Предоставьте информацию о плательщике по расчетному документу с указанными реквизитами)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 07">
	<xsl:text> (Подтвердите назначение платежа)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 08">
	<xsl:text> (Подтвердите значение указанных полей (60,61,101-110))</xsl:text>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text> &#13;&#10;Идентификаторы исходного ЭПД</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>----------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> № </xsl:text><xsl:value-of select="ed:OriginalEPD/@EDNo"/>
	<xsl:text> от </xsl:text>
	<xsl:for-each select="ed:OriginalEPD/@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> УИС : </xsl:text><xsl:value-of select="ed:OriginalEPD/@EDAuthor"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDDefineRequestInfo/@*">
		<xsl:text> &#13;&#10;Реквизиты ЭПД, поясняющие запрос</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>--------------------------------</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="ed:EDDefineRequestInfo/@AccDocNo != ''">
		<xsl:text> Номер расчетного документа              : </xsl:text>
		<xsl:value-of select="ed:EDDefineRequestInfo/@AccDocNo"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>

		<xsl:if test="ed:EDDefineRequestInfo/@AccDocDate != ''">
		<xsl:text> Дата выписки расчетного документа       : </xsl:text>
		<xsl:for-each select="ed:EDDefineRequestInfo/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/@Acc != ''">
		<xsl:text> Номер счета плательщика или получателя  : </xsl:text>
		<xsl:value-of select="ed:EDDefineRequestInfo/@Acc"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>

		<xsl:if test="ed:EDDefineRequestInfo/@Sum != ''">
		<xsl:text> Сумма                        </xsl:text>
		<xsl:for-each select="ed:EDDefineRequestInfo/@Sum"><xsl:call-template name="sum"/></xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:Name != ''">
		<xsl:text> Наименование плательщика или получателя : </xsl:text><xsl:value-of select="ed:EDDefineRequestInfo/ed:Name"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="@EDDefineRequestCode = 08">
		<xsl:text>Запрашиваемые поля</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>------------------</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field60 = '1'">
		<xsl:text> ИНН плательщика </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field61 = '1'">
		<xsl:text> ИНН получателя </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field101 = '1'">
		<xsl:text> Статус составителя </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field102 = '1'">
		<xsl:text> КПП плательщика </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field103 = '1'">
		<xsl:text> КПП получателя </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field104 = '1'">
		<xsl:text> Код бюджетной классификации </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field105 = '1'">
		<xsl:text> Код муниципального образования ОКАТО </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field106 = '1'">
		<xsl:text> Основание налогового платежа </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field107 = '1'">
		<xsl:text> Налоговый период </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field108 = '1'">
		<xsl:text> Номер налогового документа </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field109 = '1'">
		<xsl:text> Дата налогового документа </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineRequestInfo/ed:FieldQueryMask/@Field110 = '1'">
		<xsl:text> Вид платежа для налога </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED244  -->
<xsl:template match="ed:ED244">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ОТВЕТ НА ЗАПРОС ПО ЭПД УЧАСТНИКА /ED244/ </xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text>Код запроса : </xsl:text><xsl:value-of select="@EDDefineRequestCode"/>
	<xsl:if test="@EDDefineRequestCode = 00">
	<xsl:text> (Направление получателю информации без исходного запроса)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 01">
	<xsl:text> (Уточните номер банковского (лицевого) счета получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 02">
	<xsl:text> (Уточните номер банковского (лицевого) счета получателя и наименование получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 03">
	<xsl:text> (Подтвердите отсутствие дублирования расчетного документа с указанными реквизитами)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 04">
	<xsl:text> (Подтвердите наименование плательщика)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 05">
	<xsl:text> (Подтвердите наименование получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 06">
	<xsl:text> (Предоставьте информацию о плательщике по расчетному документу с указанными реквизитами)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 07">
	<xsl:text> (Подтвердите назначение платежа)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineRequestCode = 08">
	<xsl:text> (Подтвердите значение указанных полей (60,61,101-110)</xsl:text>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Код ответа  : </xsl:text><xsl:value-of select="@EDDefineAnswerCode"/>
	<xsl:if test="@EDDefineAnswerCode = 01">
	<xsl:text> (Правильность реквизитов получателя либо отсутствие дублирования расч.док-та не могут быть подтверждены)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 02">
	<xsl:text> (Направляем правильные значения реквизитов получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 03">
	<xsl:text> (Подтверждаем отсутствие дублирования по расчетному документу с указанными реквизитами)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 04">
	<xsl:text> (Подтвержденное (уточненное) наименование плательщика)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 05">
	<xsl:text> (Подтвержденное (уточненное) наименование получателя)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 06">
	<xsl:text> (Сообщаем информацию о плательщике)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 07">
	<xsl:text> (Подтвержденное (уточненное) назначение платежа)</xsl:text>
	</xsl:if>
	<xsl:if test="@EDDefineAnswerCode = 08">
	<xsl:text> (Сообщаем значение поля (полей) расчетного документа с указанным номером (номерами).)</xsl:text>
	</xsl:if>
	<xsl:text> &#13;&#10;</xsl:text>

	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text> Идентификаторы исходного ЭПД </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Номер ЭД в течение опердня           : </xsl:text><xsl:value-of select="ed:OriginalEPD/@EDNo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Дата составления ЭД                  : </xsl:text>
	<xsl:for-each select="ed:OriginalEPD/@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Уникальный идентификатор составителя : </xsl:text><xsl:value-of select="ed:OriginalEPD/@EDAuthor"/>
	<xsl:text>&#13;&#10;&#10;</xsl:text>

	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text> Реквизиты ЭПД, поясняющие ответ </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>---------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDDefineAnswerInfo/@AccDocNo != ''">
	<xsl:text>Номер расчетного документа           : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/@AccDocNo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@AccDocDate != ''">
	<xsl:text>Дата выписки расчетного документа    : </xsl:text>
	<xsl:for-each select="ed:EDDefineAnswerInfo/@AccDocDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@PayerAcc != ''">
	<xsl:text>Номер счета плательщика              : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/@PayerAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@PayeeAcc != ''">
	<xsl:text>Номер счета получателя               : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/@PayeeAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@PayerINN != ''">
	<xsl:text>ИНН плательщика                      : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/@PayerINN"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@PayeeINN != ''">
	<xsl:text>ИНН получателя                       : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/@PayeeINN"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/@Sum != ''">
	<xsl:text>Сумма                                : </xsl:text>
	<xsl:value-of select="usr:fSum(ed:EDDefineAnswerInfo/@Sum)"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/ed:PayerLongName != ''">
	<xsl:text>Наименование плательщика             : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:PayerLongName"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/ed:PayeeLongName != ''">
	<xsl:text>Наименование получателя              : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:PayeeLongName"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/ed:Purpose != ''">
	<xsl:text>Назначение платежа                   : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:Purpose"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="ed:EDDefineAnswerInfo/ed:Address != ''">
	<xsl:text>Адрес                                : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:Address"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>

	<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@*">
		<xsl:text> &#13;&#10;</xsl:text>
		<xsl:text> Список полей расчетного документа </xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>-----------------------------------</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayerINN != ''">
		<xsl:text>ИНН плательщика (поле 60)        : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayerINN"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayeeINN != ''">
		<xsl:text>ИНН получателя (поле 61 )        : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayeeINN"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DrawerStatus != ''">
		<xsl:text>Статус составителя расчетного документа (поле 101) : </xsl:text>
		<xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DrawerStatus"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayerKPP != ''">
		<xsl:text>КПП плательщика (поле 102)       : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayerKPP"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayeeKPP != ''">
		<xsl:text>КПП получателя(поле 103)         : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PayeeKPP"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@CBC != ''">
		<xsl:text>Код бюджетной классификации (поле 104): </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@CBC"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@OKATO != ''">
		<xsl:text>Код ОКАТО (поле 105)             : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@OKATO"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PaytReason != ''">
		<xsl:text>Основание налогового платежа (поле 106): </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@PaytReason"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@TaxPeriod != ''">
		<xsl:text>Налоговый период (поле 107)      : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@TaxPeriod"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DocNo != ''">
		<xsl:text>Номер налогового документа (поле 108): </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DocNo"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DocDate != ''">
		<xsl:text>Дата налогового документа (поле 109) : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@DocDate"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:if test="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@TaxPaytKind != ''">
		<xsl:text>Тип налогового платежа (поле 110)    : </xsl:text><xsl:value-of select="ed:EDDefineAnswerInfo/ed:AccDocAddInfo/@TaxPaytKind"/>
		<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED275  -->
<xsl:template match="ed:ED275">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС НА ОТЗЫВ ВЫСТАВЛЕННОГО НА ОПЛАТУ &#13;&#10;</xsl:text>
	<xsl:text>    ПЛАТЕЖНОГО ТРЕБОВАНИЯ / ИНКАССОВОГО ПОРУЧЕНИЯ /ED275/&#13;&#10;</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Вид операции                 : </xsl:text><xsl:value-of select="@TransKind"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Сумма                        : </xsl:text>
	<xsl:for-each select="@Sum"><xsl:call-template name="fsum"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Лицевой счет плательщика     : </xsl:text><xsl:value-of select="@PayerPersonalAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>БИК банка плательщика        : </xsl:text><xsl:value-of select="@PayerBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Номер счета банка плательщика: </xsl:text><xsl:value-of select="@PayerCorrespAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Лицевой счет получателя      : </xsl:text><xsl:value-of select="@PayeePersonalAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>БИК банка получателя         : </xsl:text><xsl:value-of select="@PayeeBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Номер счета банка получателя : </xsl:text><xsl:value-of select="@PayeeCorrespAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Идентификаторы исходного ЭПС : </xsl:text>
	<xsl:text>№ </xsl:text><xsl:value-of select="ed:EDRefID/@EDNo"/>
	<xsl:text> от </xsl:text>
	<xsl:for-each select="ed:EDRefID/@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> УИС : </xsl:text><xsl:value-of select="ed:EDRefID/@EDAuthor"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED301  -->
<xsl:template match="ed:ED301">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>РАСПОРЯЖЕНИЕ ДЛЯ УПРАВЛЕНИЯ ЛИКВИДНОСТЬЮ /ED301/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:for-each select="@BIC">
	<xsl:text>БИК ПУР : </xsl:text><xsl:value-of select="."/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@Sum">
	<xsl:text>Сумма операции : </xsl:text>
	<xsl:call-template name="sum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Код операции по управлению ликвидностью : </xsl:text>
	<xsl:for-each select="@LiquidityTransKind">
	<xsl:value-of select="."/>
	<xsl:if test=". = 1">
		<xsl:text> (Распоряжение на увеличение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, которую надо зарезервировать для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 2">
		<xsl:text> (Распоряжение на уменьшение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, которую надо зарезервировать для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 4">
		<xsl:text> (Распоряжение на увеличение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, на которую надо увеличить ликвидность для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 5">
		<xsl:text> (Распоряжение на уменьшение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, на которую надо уменьшить ликвидность для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	</xsl:for-each>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED306  -->
<xsl:template match="ed:ED306">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ПОДТВЕРЖДЕНИЕ ИСПОЛНЕНИЯ РАСПОРЯЖЕНИЯ ДЛЯ УПРАВЛЕНИЯ ЛИКВИДНОСТЬЮ /ED306/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:for-each select="@BIC"><xsl:text>БИК ПУР :</xsl:text><xsl:value-of select="."/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:for-each select="@Sum">
	<xsl:text>Сумма операции : </xsl:text><xsl:call-template name="sum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:text>Код операции по управлению ликвидностью : </xsl:text>
	<xsl:for-each select="@LiquidityTransKind">
	<xsl:value-of select="."/>
	<xsl:if test=". = 1">
		<xsl:text> (Распоряжение на увеличение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, которую надо зарезервировать для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 2">
		<xsl:text> (Распоряжение на уменьшение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, которую надо зарезервировать для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 4">
		<xsl:text> (Распоряжение на увеличение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, на которую надо увеличить ликвидность для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:if test=". = 5">
		<xsl:text> (Распоряжение на уменьшение суммы средств ПУР, используемых в системе БЭСП,&#13;&#10;</xsl:text>
		<xsl:text>                                             с указанием суммы, на которую надо уменьшить ликвидность для расчетов в системе БЭСП)</xsl:text>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
</xsl:template>

<!--  ED330  -->
<xsl:template match="ed:ED330">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИНФОРМАЦИЯ О КОРРЕКТИРОВКЕ ВРЕМЕННОГО РЕГЛАМЕНТА ФУНКЦИОНИРОВАНИЯ ЦОиР /ED330/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	</xsl:when> </xsl:choose>
	<xsl:for-each select="ed:CorrectionDescription">
	<xsl:text>Текст описания изменения расписания : </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="current()"/>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  ED331  -->
<xsl:template match="ed:ED331">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ОПЕРАТИВНОЙ ИНФОРМАЦИИ О СОСТОЯНИИ ЛИКВИДНОСТИ ПУР В БАНКЕ РОССИИ /ED331/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:if test="@LiquidityInquiryCode = 1">
	<xsl:text>Код запроса : 1 (Запрос информации о состоянии ликвидности только ПУР – головной КО)</xsl:text>
	</xsl:if>
	<xsl:if test="@LiquidityInquiryCode = 2">
	<xsl:text>Код запроса : 2 (Запрос информации о состоянии ликвидности ПУР с учетом ликвидности его филиалов)</xsl:text>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:choose> <xsl:when test="ed:PURBICInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Информация о БИК ПУР, состояние ликвидности которых запрашивается</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:PURBICInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

</xsl:template>

<!--  ED332 -->

<xsl:template match="ed:ED332">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ОПЕРАТИВНАЯ ИНФОРМАЦИЯ О СОСТОЯНИИ ЛИКВИДНОСТИ ПУР В БАНКЕ РОССИИ /ED332/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:if test="@EndTime != ''">
	<xsl:text>Время формирования оперативной информации : </xsl:text><xsl:value-of select="@EndTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	</xsl:when> </xsl:choose>
	<xsl:for-each select="ed:TotalLiquidity">
	<xsl:text>Информация о состоянии общей ликвидности ПУР&#13;&#10;</xsl:text>
	<xsl:text>--------------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LiqInfo"/>
	</xsl:for-each>
	<xsl:for-each select="ed:PURLiquidity">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Информация о состоянии общей ликвидности КО - филиалов&#13;&#10;</xsl:text>
	<xsl:text>---------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LiqInfo"/>
	</xsl:for-each>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED333  -->
<xsl:template match="ed:ED333">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ О ВЫПОЛНЕНИИ РЕГЛАМЕНТА СИСТЕМЫ БЭСП /ED333/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="@ProcessCode != ''">
	<xsl:text>Код процесса      : </xsl:text><xsl:value-of select="@ProcessCode"/>
	<xsl:if test="@ProcessCode = 1"><xsl:text> (Начат регулярный сеанс в системе БЭСП)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@ProcessDescription != ''">
	<xsl:text>Описание процесса : </xsl:text><xsl:value-of select="@ProcessDescription"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED373  -->
<xsl:template match="ed:ED373">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС ИНФОРМАЦИИ ОБ УЧАСТНИКАХ РАСЧЕТОВ В СИСТЕМЕ БЭСП /ED373/</xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:text>  Код запроса справочника : </xsl:text><xsl:value-of select="@DictionRequest"/>
	<xsl:if test="@DictionRequest=1"><xsl:text> Полный (со счетами)</xsl:text></xsl:if>
	<xsl:if test="@DictionRequest=2"><xsl:text> Сокращенный (без счетов)</xsl:text></xsl:if>

	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="@TUCode">
			<xsl:text>  Код ТУ : </xsl:text><xsl:value-of select="@TUCode"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@Participation"><xsl:text>  Участие в расчетах в текущем дне : </xsl:text><xsl:value-of select="@Participation"/>
			<xsl:if test="@Participation=1"><xsl:text> (участвует)</xsl:text></xsl:if>
			<xsl:if test="@Participation=2"><xsl:text> (не участвует)</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
	</xsl:choose>

	<xsl:text>  Категория участника расчетов : </xsl:text><xsl:value-of select="@MemberType"/>
	<xsl:if test="@MemberType=1"><xsl:text> (АУР)</xsl:text></xsl:if>
	<xsl:if test="@MemberType=2"><xsl:text> (ПУР)</xsl:text></xsl:if>
	<xsl:if test="@MemberType=3"><xsl:text> (ОУР)</xsl:text></xsl:if>
	<xsl:if test="@MemberType=4"><xsl:text> (Все)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="@OURBIC">
			<xsl:text>  БИК ОУР : </xsl:text><xsl:value-of select="@OURBIC"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise><xsl:text>&#13;&#10;</xsl:text></xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@BIC">
			<xsl:text>  БИК КО  : </xsl:text><xsl:value-of select="@BIC"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise><xsl:text>&#13;&#10;</xsl:text></xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@RegistrationMode">
			<xsl:text>  Вид регистрации : </xsl:text><xsl:value-of select="@RegistrationMode"/>
			<xsl:if test="@RegistrationMode=1"><xsl:text> (Зарегистрированные)</xsl:text></xsl:if>
			<xsl:if test="@RegistrationMode=2"><xsl:text> (Исключенные)</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise><xsl:text>&#13;&#10;</xsl:text></xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@StoppageMode">
			<xsl:text>  Вид временного приостановления расчетов : </xsl:text><xsl:value-of select="@StoppageMode"/>
			<xsl:if test="@StoppageMode=1"><xsl:text> (Без ограничений)</xsl:text></xsl:if>
			<xsl:if test="@StoppageMode=2"><xsl:text> (Полное ограничение)</xsl:text></xsl:if>
			<xsl:if test="@StoppageMode=3"><xsl:text> (Частичное ограничение)</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise><xsl:text>&#13;&#10;</xsl:text></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--  ED374  -->
<xsl:template match="ed:ED374">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text> ИНФОРМАЦИЯ ОБ УЧАСТНИКАХ СИСТЕМЫ БЭСП /ED374/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>  Вид справочника : </xsl:text>
	<xsl:if test="@DictionMode = 1"><xsl:text> ответ на ED334</xsl:text></xsl:if>
	<xsl:if test="@DictionMode = 2"><xsl:text> по завершению предварительного сеанса</xsl:text></xsl:if>
	<xsl:if test="@DictionMode = 3"><xsl:text> при приеме ED334 от ТУ</xsl:text></xsl:if>
	<xsl:if test="@DictionMode = 4"><xsl:text> ответ на запрос ED373</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:PartInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:choose> <xsl:when test="ed:TUInfo">
	<xsl:text>  Реквизиты ТУ участника системы БЭСП</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:TUInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>




<!--  TUInfo  -->
<xsl:template match="ed:TUInfo">
	<xsl:text>  Код ТУ          : </xsl:text> <xsl:value-of select="@TUCode"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>  Участие в расчетах в текущем дне : </xsl:text>

	<xsl:if test="@Participation = 1"><xsl:text> участвует</xsl:text></xsl:if>
	<xsl:if test="@Participation = 2"><xsl:text> не участвует</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>  Наименование ТУ : </xsl:text> <xsl:value-of select="ed:Name"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:CustomerInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:CustomerInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

</xsl:template>

<!--  CustomerInfo  -->
<xsl:template match="ed:CustomerInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>  Реквизиты клиента, по которому предоставляется информация об атрибутах участия в системе БЭСП</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>  БИК ОУР : </xsl:text> <xsl:value-of select="@OURBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="@BIC">
	<xsl:text>  БИК КО  : </xsl:text> <xsl:value-of select="@BIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="@UIS">
	<xsl:text>  Уникальный идентификатор, присвоенный составителю/получателю ЭС : </xsl:text> <xsl:value-of select="@UIS"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="@ParentBIC">
	<xsl:text>  БИК головной КО : </xsl:text> <xsl:value-of select="@ParentBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:text>  Категория участника расчетов : </xsl:text>
	<xsl:if test="@MemberType = 1"><xsl:text> АУР</xsl:text></xsl:if>
	<xsl:if test="@MemberType = 2"><xsl:text> ПУР</xsl:text></xsl:if>
	<xsl:if test="@MemberType = 3"><xsl:text> ОУР</xsl:text></xsl:if>
	<xsl:if test="@MemberType = 4"><xsl:text> Все</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>  Вид регистрации  : </xsl:text>
	<xsl:if test="@RegistrationMode = 1"><xsl:text> зарегистрированные (1)</xsl:text></xsl:if>
	<xsl:if test="@RegistrationMode = 2"><xsl:text> исключенные (2)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>  Дата регистрации : </xsl:text>
	<xsl:for-each select="@RegistrationDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose>
	<xsl:when test="@ExceptionDate">
			<xsl:text>  Дата исключения из расчетов : </xsl:text>
			<xsl:for-each select="@ExceptionDate"><xsl:call-template name="date"/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@StoppageMode">
			<xsl:text>  Вид ограничения участия : </xsl:text>
			<xsl:if test="@StoppageMode = 1"><xsl:text>  нет приостановления (1)</xsl:text></xsl:if>
			<xsl:if test="@StoppageMode = 2"><xsl:text>  расчеты временно приостановлены (2)</xsl:text></xsl:if>
			<xsl:if test="@StoppageMode = 3"><xsl:text>  временно приостановлены прием и обработка платежей (3)</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@StoppageDate">
			<xsl:text>  Дата установки ограничения участия : </xsl:text>
			<xsl:for-each select="@StoppageDate"><xsl:call-template name="date"/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@StoppageEndDate">
			<xsl:text>  Дата снятия ограничения участия : </xsl:text>
			<xsl:for-each select="@StoppageEndDate"><xsl:call-template name="date"/></xsl:for-each>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="@StoppageReason">
			<xsl:text>  Причина введения ограничения участия : </xsl:text  >
			<xsl:if test="@StoppageReason = 01">
			<xsl:text>  Возникновение временных технических проблем </xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 02">
			<xsl:text>  Предъявление к банковскому счету ПУР инкассового поручения</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 03">
			<xsl:text>  Наличие на конец дня картотеки неоплаченных в срок документов</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 04">
			<xsl:text>  Неустранение  ПУР причин временного приостановления участия в системе БЭСП до окончания операционного дня системы БЭСП</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 05">
			<xsl:text>  Несоответствие ПУР требованиям к участникам</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 06">
			<xsl:text>  Возникновение указанных в договоре причин временного отключения</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 07">
			<xsl:text>  Начато проведение мероприятий по исключению из состава участников системы БЭСП</xsl:text>
			</xsl:if>
			<xsl:if test="@StoppageReason = 09">
			<xsl:text>  Прочее</xsl:text>
			</xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>
	<xsl:choose>
	<xsl:when test="@ReasonAddText">
			<xsl:text>Дополнительное разъяснение о причине установки временного ограничения : </xsl:text>
			<xsl:value-of select="@ReasonAddText"/>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when>
	</xsl:choose>

	<xsl:text>  Наименование клиента : </xsl:text> <xsl:value-of select="ed:Name"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:AdditionalConditions">
	<xsl:text>  Дополнительные условия проведения платежей или осуществления расчетов :</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:AdditionalConditions/@UrgentPayments">
			<xsl:text>     Разрешение экстренных платежей: </xsl:text>
			<xsl:if test="ed:AdditionalConditions/@UrgentPayments = 1"><xsl:text>  есть</xsl:text></xsl:if>
			<xsl:if test="ed:AdditionalConditions/@UrgentPayments = 2"><xsl:text>  нет</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>

	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="ed:AdditionalConditions/@CrossPayments">
			<xsl:text>     Разрешение двустороннего взаимозачета: </xsl:text>
			<xsl:if test="ed:AdditionalConditions/@CrossPayments = 1"><xsl:text>  есть</xsl:text></xsl:if>
			<xsl:if test="ed:AdditionalConditions/@CrossPayments = 2"><xsl:text>  нет</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="ed:AdditionalConditions/@SuspendedMode">
			<xsl:text>     Вид обработки внутридневной очереди при завершении расчетов: </xsl:text>
			<xsl:if test="ed:AdditionalConditions/@SuspendedMode = 1"><xsl:text>  платежи передаются</xsl:text></xsl:if>
			<xsl:if test="ed:AdditionalConditions/@SuspendedMode = 2"><xsl:text>  платежи аннулируются</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>
	<xsl:choose> <xsl:when test="ed:AdditionalConditions/@SWIFTMode">
			<xsl:text>     Признак взаимодействия через систему S.W.I.F.T. : </xsl:text>
			<xsl:if test="ed:AdditionalConditions/@SWIFTMode = 1"><xsl:text>  участник SWIFT</xsl:text></xsl:if>
			<xsl:if test="ed:AdditionalConditions/@SWIFTMode = 2"><xsl:text>  не участник SWIFT</xsl:text></xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>
	<xsl:choose> <xsl:when test="ed:AdditionalConditions/@LimitedMode">
			<xsl:text>     Вид лимитирования платежей : </xsl:text>
			<xsl:if test="ed:AdditionalConditions/@LimitedMode = 1">
			<xsl:text>  лимитирование не применяется</xsl:text>
			</xsl:if>
			<xsl:if test="ed:AdditionalConditions/@LimitedMode = 2">
			<xsl:text>  применяются двусторонние лимиты</xsl:text>
			</xsl:if>
			<xsl:if test="ed:AdditionalConditions/@LimitedMode = 3">
			<xsl:text>  применяются многосторонние лимиты</xsl:text>
			</xsl:if>
			<xsl:if test="ed:AdditionalConditions/@LimitedMode = 4">
			<xsl:text>  применяются много- или двусторонние лимиты</xsl:text>
			</xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>


	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="ed:PURBICInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Информация о БИК ПУР, в отношении которых применяется двусторонний лимит</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:PURBICInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:choose> <xsl:when test="ed:ListAcc">
	<xsl:text>  Список счетов</xsl:text>
	<xsl:text>&#13;&#10;  -------------&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:ListAcc"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>
</xsl:template>

<xsl:template match="ed:ListAcc">
	<xsl:text>  Лицевой счет ОУР или коррсчет АУР : </xsl:text><xsl:value-of select="@Acc"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="ed:PURBICInfo">
	<xsl:text>  БИК : </xsl:text> <xsl:value-of select="@BIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--dsig:SigValue-->
<xsl:template match="dsig:SigValue" xmlns:dsig="urn:cbr-ru:dsig:v1.1">
	<!-- Маскируем появление подписи и ничего не выводим -->
</xsl:template>

<!-- Отображаем для НСИ другую ветку -->
<xsl:template match="ed:ED231">
<!--
Отображаем клиенту необходимость выполнить преобразование
по другой ветке
-->
<xsl:text>&#13;&#10;</xsl:text>
<xsl:text>&#13;&#10;</xsl:text>
<xsl:text>Файл содержит: ED231 Данные Справочника БИК </xsl:text>
<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="ed:ED232">
<xsl:text>&#13;&#10;</xsl:text>
<xsl:text>Файл содержит: ED232 Данные плана счетов </xsl:text>
<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="ed:ED233">
<xsl:text>&#13;&#10;</xsl:text>
<xsl:text>Файл содержит: ED233 Данные по закрытым счетам </xsl:text>
<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="ed:ED234">
<xsl:text>&#13;&#10;</xsl:text>
<xsl:text>Файл содержит: ED234 Данные по счетам особых клиентов и счетам доверительного управления КО</xsl:text>
<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!--  ED375  -->
<xsl:template match="ed:ED375">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИЗВЕЩЕНИЕ ОБ ОТМЕНЕ УСТАНОВЛЕННОГО ЛИМИТА ПУР В СИСТЕМЕ БЭСП /ED375/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:for-each select="ed:CancelledLimitInfo">
	<xsl:text>Информация об отмененном лимите&#13;&#10;</xsl:text>
	<xsl:text>------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LimitTransKind"/>
	<xsl:call-template name="LimitInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--  ED378  -->
<xsl:template match="ed:ED378">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>РАСПОРЯЖЕНИЕ НА УСТАНОВКУ И ИЗМЕНЕНИЕ ЛИМИТА В СИСТЕМЕ БЭСП /ED378/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:call-template name="LimitTransKind"/>
	<xsl:text>БИК ПУР, который устанавливает лимит : </xsl:text><xsl:value-of select="@PURBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:for-each select="ed:LimitInfo">
	<xsl:text>Информация об устанавливаемом лимите&#13;&#10;</xsl:text>
	<xsl:text>---------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LimitInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED379  -->
<xsl:template match="ed:ED379">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ПОДТВЕРЖДЕНИЕ РАСПОРЯЖЕНИЯ НА УСТАНОВКУ И ИЗМЕНЕНИЕ ЛИМИТА В СИСТЕМЕ БЭСП /ED379/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:call-template name="LimitTransKind"/>
	<xsl:text>БИК ПУР, который устанавливает лимит : </xsl:text><xsl:value-of select="@PURBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:for-each select="ed:LimitInfo">
	<xsl:text>Информация об устанавливаемом лимите&#13;&#10;</xsl:text>
	<xsl:text>---------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LimitInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--  ED380  -->
<xsl:template match="ed:ED380">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС О ЛИМИТАХ В СИСТЕМЕ БЭСП /ED380/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:call-template name="LimitTransKind"/>
	<xsl:if test="@LimitDirection!=''">
	<xsl:text>Направление лимита : </xsl:text><xsl:value-of select="@LimitDirection"/>
	<xsl:if test="@LimitDirection=1"><xsl:text> (Автором сообщения)&#13;&#10;</xsl:text></xsl:if>
	</xsl:if>
	<xsl:if test="@PURBIC!=''">
	<xsl:text>БИК ПУР, который устанавливает (на который установлен) лимит : </xsl:text><xsl:value-of select="@PURBIC"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
</xsl:template>

<!--  ED381 -->
<xsl:template match="ed:ED381">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ИНФОРМАЦИЯ О ЛИМИТАХ В СИСТЕМЕ БЭСП/ED381/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:choose> <xsl:when test="ed:PartInfo">
	<xsl:apply-templates select="ed:PartInfo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:when> </xsl:choose>

	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>

	<xsl:for-each select="ed:LimitInfoExt">
	<xsl:text>Информация об установленном лимите&#13;&#10;</xsl:text>
	<xsl:text>---------------------------------------&#13;&#10;</xsl:text>
	<xsl:call-template name="LimitInfo"/>
	<xsl:call-template name="LimitTransKind"/>
	<xsl:if test="@LimitDirection!=''">
	<xsl:text>Направление лимита : </xsl:text><xsl:value-of select="@LimitDirection"/>
	<xsl:if test="@LimitDirection=1"><xsl:text> (Автором сообщения)&#13;&#10;</xsl:text></xsl:if>
	</xsl:if>
	<xsl:for-each select="@BalancePayts">
	<xsl:text>Баланс платежей : </xsl:text><xsl:call-template name="sum"/>
	</xsl:for-each>
	<xsl:for-each select="@LimitLiquidity">
	<xsl:text>Предел ликвидности : </xsl:text><xsl:call-template name="sum"/>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--  ED382  -->
<xsl:template match="ed:ED382">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>РАСПОРЯЖЕНИЕ НА ИЗМЕНЕНИЕ ПРИОРИТЕТА ПЛАТЕЖА БЭСП /ED382/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>Приоритет платежа (ЭПД) : </xsl:text><xsl:value-of select="@PaymentPriority"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED383  -->
<xsl:template match="ed:ED383">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>РАСПОРЯЖЕНИЕ НА УСТАНОВКУ И ИЗМЕНЕНИЕ ЛИМИТА В СИСТЕМЕ БЭСП /ED383/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>

<!--  ED385  -->
<xsl:template match="ed:ED385">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ПОДТВЕРЖДЕНИЕ ОБРАБОТКИ РАСПОРЯЖЕНИЙ НА УПРАВЛЕНИЕ ОЧЕРЕДЬЮ ПЛАТЕЖЕЙ БЭСП /ED385/</xsl:text>
	<xsl:call-template name="PriznGr"/>

	<xsl:text>Время проведения операции : </xsl:text><xsl:value-of select="@OperationTime"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
	<xsl:if test="ed:EDRefID/@EDNo != ''">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:apply-templates select="ed:EDRefID"/>
	</xsl:if>
</xsl:template>


<!--  ED501  -->
<xsl:template match="ed:ED501">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ДОКУМЕНТ СОБСТВЕННОГО ФОРМАТА /ED501/ </xsl:text>
	<xsl:call-template name="PriznGr"/>
	<xsl:if test="ed:InitialED/@EDNo != ''">
	<xsl:apply-templates select="ed:InitialED"/>
	</xsl:if>
</xsl:template>

<!--  ED999  -->
<xsl:template match="ed:ED999">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="concat(position()-$modif_pos,'.  ')"/>
	<xsl:text>ЗАПРОС-ЗОНД /ED999/ </xsl:text>
	<xsl:call-template name="PriznGr"/>
</xsl:template>



<!--   Служебный конверт  -->
<xsl:template match="env:Envelope">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>СЛУЖЕБНЫЙ КОНВЕРТ</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:for-each select="env:Header/props:MessageInfo/props:To">
	<xsl:text>Адрес получателя                  : </xsl:text><xsl:value-of select="current()"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>

	<xsl:text>Адрес отправителя                 : </xsl:text><xsl:value-of select="env:Header/props:MessageInfo/props:From"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:for-each select="env:Header/props:MessageInfo/props:MessageType">
	<xsl:text>Тип электронного сообщения        : </xsl:text><xsl:value-of select="current()"/>
	<xsl:if test="current() = '1'"><xsl:text> (сообщения платежной системы) </xsl:text></xsl:if>
	<xsl:if test="current() = '2'"><xsl:text> (для обмена информационными данными) </xsl:text></xsl:if>
	<xsl:if test="current() = '3'"><xsl:text> (для технологических сообщений-квитанций) </xsl:text></xsl:if>
	<xsl:if test="current() = '5'"><xsl:text> (другие служебные сообщения) </xsl:text></xsl:if>
	</xsl:for-each>

	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Имя файла                         : </xsl:text>
	<xsl:value-of select="env:Header/props:MessageInfo/props:LegacyTransportFileName"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Дата и время создания транспортного сообщения : </xsl:text>
	<xsl:value-of select="env:Header/props:MessageInfo/props:CreateTime"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:for-each select="env:Header/props:DocInfo">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Идентификационная информация </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>-------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Формат сообщения : </xsl:text><xsl:value-of select="props:DocFormat"/>
	<xsl:if test="props:DocFormat = '1'"><xsl:text> (УФЭБС) </xsl:text></xsl:if>
	<xsl:if test="props:DocFormat = '2'"><xsl:text> (внутренний формат ТПК УОС) </xsl:text></xsl:if>
	<xsl:if test="props:DocFormat = '3'"><xsl:text> (файлы ПУ, МЭР) </xsl:text></xsl:if>
	<xsl:if test="props:DocFormat = '9'"><xsl:text> (другие) </xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Тип сообщения    : </xsl:text><xsl:value-of select="props:DocType"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:if test="props:DocFormat = '1'">
	<xsl:text>Реквизиты сообщения УФЭБС</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>-------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:for-each select="props:EDRefID">
		<xsl:text>Электронный документ № </xsl:text><xsl:value-of select="@EDNo"/>
		<xsl:text> от </xsl:text>
		<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
		<xsl:text>  УИС : </xsl:text><xsl:value-of select="@EDAuthor"/>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="props:DocID != ''">
	<xsl:text>Идентификатор передаваемого сообщения : </xsl:text><xsl:value-of select="props:DocID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:if>
	</xsl:for-each>
	<xsl:for-each select="env:Header/props:AcknowledgementInfo">
	<xsl:text>Тип квитанции                     : </xsl:text><xsl:value-of select="props:AcknowledgementType"/>
	<xsl:if test="props:AcknowledgementType = '1'"><xsl:text> (отправка) </xsl:text></xsl:if>
	<xsl:if test="props:AcknowledgementType = '2'"><xsl:text> (поступление в зону ответственности УБР или участника) </xsl:text></xsl:if>
	<xsl:if test="props:AcknowledgementType = '3'"><xsl:text> (прочтение приложением-получателем) </xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Результат транспортной операции   : </xsl:text><xsl:value-of select="props:ResultCode"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:if test="props:ResultText != ''">
	<xsl:text>Описание результата операции      : </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:value-of select="props:ResultText"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>

	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--   ЭЦП   -->
<xsl:template match="sen:SigEnvelope">
	<xsl:text>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:text>Файл в формате SigEnvelope</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>



<!--  PartInfo  -->
<xsl:template match="ed:PartInfo">
	<xsl:text>-------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>    Информация о части</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>    Номер части       : </xsl:text> <xsl:value-of select="@PartNo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>    Количество частей : </xsl:text> <xsl:value-of select="@PartQuantity"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>    Уникальный идентификатор совокупности частей : </xsl:text> <xsl:value-of select="@PartAggregateID"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>-------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  InitialED  -->
<xsl:template match="ed:InitialED">
	<xsl:text> &#13;&#10;</xsl:text>
	<xsl:text> Идентификаторы исходного ЭСИД - запроса </xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>-----------------------------------------</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Номер расчетного документа           : </xsl:text><xsl:value-of select="@EDNo"/>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Дата выписки расчетного документа    : </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Уникальный идентификатор составителя : </xsl:text><xsl:value-of select="@EDAuthor"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!--  EDRefID  -->
<xsl:template match="ed:EDRefID">
	<!-- <xsl:text>&#13;&#10;</xsl:text>  -->
	<xsl:text>Идентификаторы исходного ЭД (пакета ЭД) : </xsl:text>
	<xsl:text>№ </xsl:text><xsl:value-of select="@EDNo"/>
	<xsl:text> от </xsl:text>
	<xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text> УИС: </xsl:text><xsl:value-of select="@EDAuthor"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!-- Переменная "modif_pos" содержит кол-во узлов, предшествующих нумеруемым узлам -->

<xsl:variable name="modif_pos" select="count(ed:PacketEPD/dsig:SigValue) + count(ed:PacketESID/dsig:SigValue) +
	count(ed:PacketESID/ed:InitialPacketED)" />

<!--  Преобразование суммы из копеек в формат "рубли.копейки"  -->
<!--  Значение дополнено слева пробелами до 21 символа -->
<xsl:template name="sum">
<xsl:value-of
	select = "concat(substring('                     ',1,21-string-length(current())),substring(current(),1,
			string-length(current())-2),'.', substring(current(),string-length(current())-1,2))"/>
</xsl:template>

<!--  Преобразование суммы из копеек в формат "рубли.копейки" (рубли отформатированы в группы по 3 знака) -->
<!--  Значение дополнено слева пробелами до 18 символов(?) -->
<xsl:decimal-format name="ru" decimal-separator='.' grouping-separator=' ' />
<xsl:template name="fsum">
	<xsl:variable name="modif_sum"
	select="concat(format-number(substring(current(),1,string-length(current())-2),'### ##0','ru'),
	'.',substring(current(),string-length(current())-1,2))"/>
	<xsl:value-of select="concat(substring('                  ',1,18 - string-length($modif_sum)),$modif_sum)"/>
</xsl:template>

<xsl:template name="UTC2MoscowTime">
	<xsl:choose>
		<xsl:when test="(number(substring-before(current(),':'))+4)>24">
			<xsl:value-of select="concat((number(substring-before(current(),':'))-20), ':', substring-after(current(),':'))"/>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="concat((number(substring-before(current(),':'))+4), ':', substring-after(current(),':'))"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--  Шаблон для удаления пробелов слева.

<xsl:template name="Trim">
	<xsl:param name="input"/>
	<xsl:choose>
		<xsl:when test="contains($input, ' ')">
			<xsl:value-of select="substring-before($input, ' ')"/>
			<xsl:call-template name="Trim">
				<xsl:with-param name="input" select="substring-after($input,' ')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$input"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>
-->


<!--  Преобразование даты из формата ГГГГ-ММ-ДД в ДД.ММ.ГГГГ  -->

<xsl:template name="date">
	<xsl:value-of select="concat(substring(current(),9,2),'.',substring(current(),6,2),'.',substring(current(),1,4))"/>
</xsl:template>

<!--  Вывод призначной группы в виде ЭД № NNNNNN от ДД.ММ.ГГГГ  УИС : NNNNNNNNNN [(МЦИ при Банке России)]  [УИП : NNNNNNNNNN]  -->

<xsl:template name="PriznGr">
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Электронный документ № </xsl:text><xsl:value-of select="@EDNo"/>
	<xsl:text> от </xsl:text><xsl:for-each select="@EDDate"><xsl:call-template name="date"/></xsl:for-each>
	<xsl:text>, составитель </xsl:text><xsl:value-of select="@EDAuthor"/>
	<xsl:if test="@EDAuthor = 4583001999"><xsl:text> (МЦИ при Банке России)</xsl:text></xsl:if>
	<xsl:if test="@EDReceiver != ''">
	<xsl:text>&#13;&#10;Идентификатор получателя: </xsl:text><xsl:value-of select="@EDReceiver"/>
	</xsl:if>
	<xsl:if test="@ActualReceiver != ''">
	<xsl:text>&#13;&#10;Идентификатор получателя: </xsl:text><xsl:value-of select="@ActualReceiver"/>
	</xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  Вывод оперативной информации по лимитам  -->

<!--  LiqInfo  -->
<xsl:template name="LiqInfo">
	<xsl:text>БИК ПУР : </xsl:text>
	<xsl:value-of select="@BIC"/>
	<xsl:text>   Время формирования оперативной информации : </xsl:text><xsl:value-of select="@PKOITUTime"/>
	<xsl:text>&#13;&#10;</xsl:text>

	<xsl:for-each select="ed:Liquidity">
	<xsl:for-each select="@LiquiditySum">
	<xsl:text>   1.Общая сумма&#13;&#10;</xsl:text>
	<xsl:text>   -----------------&#13;&#10;</xsl:text>
	<xsl:text>   Сумма ликвидных средств ПУР   : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@Debt">
	<xsl:text>   Использованный кредит ВДК/ОВН : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="ed:CorrespAccBal">
	<xsl:for-each select="@OutBal">
	<xsl:text>   2.Остаток средств на корсчете КО в УБР&#13;&#10;</xsl:text>
	<xsl:text>   ------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>   Сумма средств в позиции корсчета КО : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@CreditLimitSum">
	<xsl:text>   Cумма установленного лимита ВДК/ОВН : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@ReservedSum">
	<xsl:text>   Сумма забронированных средств       : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="ed:RTGSLiquidity">
	<xsl:for-each select="@RTGSOutBal">
	<xsl:text>   3.Состояние позиции по ликвидности ПУР в БЭСП&#13;&#10;</xsl:text>
	<xsl:text>   ---------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>   Сумма средств в позиции счета ПУР в ЦР : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@RTGSReservedSum">
	<xsl:text>   Сумма забронированных средств на счете : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="ed:PaytTurnState">
	<xsl:for-each select="@TUTurnPayment">
	<xsl:text>   4.Состояние очереди отложенных платежей&#13;&#10;</xsl:text>
	<xsl:text>   ----------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>   Состояние очереди отложенных платежей в УОС ТУ       : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	<xsl:for-each select="@RTGSTurnPayment">
	<xsl:text>   Состояние очереди отложенных платежей в системе БЭСП : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="ed:EstimatedIncome">
	<xsl:for-each select="@EstimatedIncomeSum">
	<xsl:text>   5.Ожидаемые поступления от других участников системы БЭСП&#13;&#10;</xsl:text>
	<xsl:text>   ----------------------------------------------------------&#13;&#10;</xsl:text>
	<xsl:text>   Сумма ожидаемых поступлений  : </xsl:text><xsl:call-template name="fsum"/>
	<xsl:text>&#13;&#10;</xsl:text>
	</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<!--  LimitTransKind  -->
<xsl:template name="LimitTransKind">
	<xsl:text>Вид лимита      : </xsl:text>
	<xsl:value-of select="@LimitTransKind"/>
	<xsl:if test="@LimitTransKind=0"><xsl:text> (Все)</xsl:text></xsl:if>
	<xsl:if test="@LimitTransKind=1"><xsl:text> (Общий)</xsl:text></xsl:if>
	<xsl:if test="@LimitTransKind=2"><xsl:text> (Двусторонний)</xsl:text></xsl:if>
	<xsl:if test="@LimitTransKind=3"><xsl:text> (Многосторонний)</xsl:text></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--  LimitInfo  -->
<xsl:template name="LimitInfo">
	<xsl:if test="@PURBIC!=''"><xsl:text>БИК ПУР         : </xsl:text><xsl:value-of select="@PURBIC"/></xsl:if>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:text>Сумма лимита    : </xsl:text><xsl:for-each select="@LimitSum"><xsl:call-template name="fsum"/></xsl:for-each>
	<xsl:text>&#13;&#10;&#10;</xsl:text>
</xsl:template>

<msxsl:script language="JScript" implements-prefix="usr">
<![CDATA[
	// Преобразование даты из формата ГГГГ-ММ-ДД в ДД.ММ.ГГГГ
	function fDate(s){
		return s[0].text.replace(/(\d{4})\-(\d{2})\-(\d{2})/, '$3.$2.$1');
	}

	// Преобразование суммы из копеек в формат "рубли.копейки"
	function fSum(s){
		return ('00'+s[0].text).replace(/0*(\d+)(\d\d)$/, '$1.$2');
	}
]]>
</msxsl:script>

</xsl:stylesheet>
