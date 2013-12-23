<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
				xmlns:kml="http://www.opengis.net/kml/2.2"
				xmlns:gx="http://www.google.com/kml/ext/2.2"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml"
				indent="yes" />

	<xsl:template match="/">
		<gpx version="1.1"
			 creator="kml2gpx.xslt"
			 xmlns="http://www.topografix.com/GPX/1/1">
			 <xsl:for-each select="//gx:Track">
				 <trk>
					 <trkseg>
						 <xsl:for-each select="kml:when">
							 <!-- Timestamp -->
							 <xsl:variable name="ts" select="."/>
							 <!-- Coordinates -->
							 <xsl:variable name="lonlat" select="./following-sibling::gx:coord"/>
							 <xsl:variable name="lon" select="substring-before($lonlat,' ')"/>
							 <xsl:variable name="latele" select="substring-after($lonlat,' ')"/>
							 <xsl:variable name="lat">
								 <xsl:choose>
									 <xsl:when test="contains($latele,' ')">
										 <xsl:value-of select="substring-before($latele,' ')"/>
									 </xsl:when>
									 <xsl:otherwise>
										 <xsl:value-of select="$latele"/>
									 </xsl:otherwise>
								 </xsl:choose>
							 </xsl:variable>
							 <trkpt lon="{$lon}" lat="{$lat}">
								 <time><xsl:value-of select="$ts"/></time>
							 </trkpt>
						 </xsl:for-each>
					 </trkseg>
				 </trk>
			</xsl:for-each>
		</gpx>
	</xsl:template>

	<xsl:template match="gx:Track">
	</xsl:template>

</xsl:stylesheet>