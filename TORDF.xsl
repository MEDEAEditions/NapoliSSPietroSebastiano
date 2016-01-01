<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:rem="http://gams.uni-graz.at/rem/bookkeeping/#"
    xmlns:ssps="http://gams.uni-graz.at/rem/o:ssps1485/#"
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:variable name="documentURI">http://gams.uni-graz.at/<xsl:value-of select="//t:idno[@type='PID']"/></xsl:variable>
    <xsl:template match="/">
        <rdf:RDF>
            <!-- 
                1. Extrahiere alle #bk_entry
                2. Trage dazu den Text ein (#bk_description ?)
                3. Konvertiere den Betrag (#bk_amount) auf die kleinste Einheit des Währungssystems in taxonomy@xml:id="units" und trage ihn dazu ein
                4. Ergänze Datumsangaben (*[@ana(matches(.,#bk_entry))]/date[1])
            -->
            <xsl:apply-templates select="//*[matches(@ana,'#bk_entry')]"/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="//*[matches(@ana,'#bk_entry')]">
        <rem:entry rdf:about="{rem:uri(.)}">
            <rem:description><xs:value-of select=".//text()"/></rem:description>
            <rem:date><xsl:value-of select=".//t:date[1]"/></rem:date>
        </rem:entry>
    </xsl:template>
    <xsl:template match="*[matches(@ana,'#bk_amount')]">
        <rem:amount>
            <rem:MonetaryValue>
                <rem:unit rdf:about="ssps:g"></rem:unit>
                <rem:quantity><xsl:value-of select="sum(.//t:measure[matches(@type,'rem:MonetaryValue')]/num/rem:convert(.,'g'))"/></rem:quantity>
                <rem:signOfAmount rdf:about="rem:i"></rem:signOfAmount>
            </rem:MonetaryValue>
        </rem:amount>
    </xsl:template>
    <xsl:function name="rem:uri">
        <xsl:param name="me"/>
        <xsl:value-of select="$documentURI"/>
        <xsl:text>#</xsl:text>
        <xsl:choose>
            <xsl:when test="$me/@xml:id">
                <xsl:value-of select="$me/@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$me/generate-id()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="rem:convert">
        <xsl:param name="amount"/>
        <xsl:param name="from"/>
        <xsl:param name="to"/>
        <!-- 
            Konvertiert $amount aus der Einheit $from in die Einheit $to
            nach einer rem:Conversion-Angabe (ggf. rekursiv):
                choose
                    when rem:Conversion[from=$from, ./to=$to]
                        
                    otherwise
                        rem:convert(rem:Conversion[from=$from][1],$to)
        -->
    </xsl:function>
    <xsl:function name="rem:roman2int">
        <xsl:param name="roman"/>
        <!-- Vgl. conversions.xsl -->
    </xsl:function>
</xsl:stylesheet>