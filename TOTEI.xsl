<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:rem="http://gams.uni-graz.at/rem/bookkeeping/#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:measure">
        <!-- hier sollte jetzt:
                
        num@value eingefügt werden
            * jedes num ohne @value: rem:roman2int() (aus conversions.xsl ?) (erweitern um Test, ob der Wert überhaupt eine römische Zahl sein kann?)
        
        Die Umrechnung der measures in eine Basis-Quantity vorbereitet werden:
            * als TOHTML-Datenpunkte?
       Die Anzeige der Angaben nach Zeiten geordnet vorbereitet werden:

        Kontoangaben vorbereitet werden: Derzeit gibt es keine Textstrukturen, die das deutlich machen. Am ehesten wären die "Gegenstände" zu gruppieren
            
        -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="*" priority="-2">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*|text()|comment()|processing-instruction()" priority="-2">
        <xsl:copy/>
    </xsl:template>
</xsl:stylesheet>