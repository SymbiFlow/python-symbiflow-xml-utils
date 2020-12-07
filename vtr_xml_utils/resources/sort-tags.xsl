<?xml version="1.0"?>
<!-- 
 Copyright (C) 2020  The SymbiFlow Authors.

 Use of this source code is governed by a ISC-style
 license that can be found in the LICENSE file or at
 https://opensource.org/licenses/ISC

 SPDX-License-Identifier:   ISC
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:include href="identity.xsl" />

 <!-- Sort <pb_type><clock> by "name" attribute -->
 <!-- Sort <pb_type><input> by "name" attribute -->
 <!-- Sort <pb_type><output> by "name" attribute -->
 <xsl:template match="pb_type">
  <xsl:copy>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates select="clock">
    <xsl:sort select="@name" order="ascending"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="input">
    <xsl:sort select="@name" order="ascending"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="output">
    <xsl:sort select="@name" order="ascending"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="delay_constant">
    <xsl:sort select="concat(@out_port,@in_port)" order="ascending"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="pb_type">
    <xsl:sort select="@name" order="ascending"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="*[not(self::clock or self::input or self::output or self::pb_type or self::delay_constant)]"/>
  </xsl:copy>
 </xsl:template>
 <!-- Sort <interconnect><XXX> tags by output - direct first then muxes, finally input -->
 <xsl:template match="interconnect">
  <xsl:copy>
   <xsl:apply-templates>
    <xsl:sort select="concat(@output, name(), @input)" order="ascending"/>
   </xsl:apply-templates>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
