<?xml version='1.0'?>

<!-- LaTeX/PDF styling for standalone worksheet PDFs only, as distinct   -->
<!-- from any custom XSL for other target types.  Wired in via the      -->
<!-- target/@xsl attribute on the ws-*-pdf and ws-*-tex targets in      -->
<!-- project.ptx; never loaded for problem sets or for the HTML/SCORM   -->
<!-- worksheet targets, so nothing here needs to guard on               -->
<!-- ancestor::worksheet: every target that imports this file only      -->
<!-- ever processes worksheet documents.                                -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="./core/pretext-latex.xsl"/>

<!-- Update these once per semester -->
<xsl:variable name="worksheet-course-name">MATH-UA 122 Calculus II</xsl:variable>

<!-- xcolor's [HTML] model needs no \definecolor and is used inline below, -->
<!-- since xcolor is already loaded unconditionally by core (for -->
<!-- tcolorbox support), and xsl:apply-imports is unreliable inside a -->
<!-- *named* template (only matched template rules have a well-defined -->
<!-- "current template rule" for it to fall back to), so overriding the -->
<!-- named "late-preamble-adjustments" template to add a \definecolor is -->
<!-- avoided entirely. -->
<xsl:variable name="worksheet-nyu-violet">57068C</xsl:variable>

<!-- ==================================================================== -->
<!-- Page-1 header: course name and a blank line for the student's name,  -->
<!-- printed above the worksheet's normal title.                          -->
<!--                                                                      -->
<!-- This is a full reimplementation, not an apply-imports + append,     -->
<!-- because \newgeometry (called for the margin change) includes a      -->
<!-- \clearpage.  Content has to be sequenced *after* that clearpage but  -->
<!-- *before* \begin{worksheet...}, since the title itself is typeset as  -->
<!-- part of that \begin's own argument-processing.  Everything below   -->
<!-- besides the header text reuses the same shared modes/templates the   -->
<!-- core "latex-division-heading" template does, so title text,         -->
<!-- environment naming, and unique-id generation stay in sync with core. -->
<!-- ==================================================================== -->
<xsl:template match="worksheet" mode="latex-division-heading">
    <xsl:if test="$b-latex-worksheet-formatted">
        <!-- \newgeometry includes a \clearpage -->
        <xsl:apply-templates select="." mode="new-geometry"/>
    </xsl:if>
    <xsl:text>\noindent </xsl:text>
    <xsl:value-of select="$worksheet-course-name"/>
    <xsl:text>\hfill Name:\ \makebox[2.25in]{\hrulefill}\par&#xa;</xsl:text>
    <xsl:text>\smallskip\hrule\bigskip&#xa;</xsl:text>
    <xsl:text>\begin{</xsl:text>
    <xsl:apply-templates select="." mode="division-environment-name" />
    <xsl:apply-templates select="." mode="division-environment-name-suffix" />
    <xsl:text>}{</xsl:text>
    <xsl:apply-templates select="." mode="type-name"/>
    <xsl:text>}{</xsl:text>
    <xsl:apply-templates select="." mode="title-full"/>
    <xsl:text>}{}{</xsl:text>
    <xsl:apply-templates select="." mode="title-short"/>
    <xsl:text>}{}{}{</xsl:text>
    <xsl:apply-templates select="." mode="unique-id" />
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- ==================================================================== -->
<!-- NYU Violet solution text.  A thin reimplementation (rather than       -->
<!-- apply-imports) because XSLT 1.0's xsl:apply-imports cannot carry      -->
<!-- xsl:with-param children, and the imported "solution" template needs   -->
<!-- its params forwarded.                                                 -->
<!-- ==================================================================== -->
<xsl:template match="solution">
    <xsl:param name="b-original" />
    <xsl:param name="purpose" />
    <xsl:param name="b-component-heading"/>

    <xsl:text>\begingroup\color[HTML]{</xsl:text>
    <xsl:value-of select="$worksheet-nyu-violet"/>
    <xsl:text>}%&#xa;</xsl:text>
    <xsl:apply-templates select="." mode="newpage"/>
    <xsl:apply-templates select="." mode="solution-heading">
        <xsl:with-param name="b-original" select="$b-original" />
        <xsl:with-param name="purpose" select="$purpose" />
        <xsl:with-param name="b-component-heading" select="$b-component-heading"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="*">
        <xsl:with-param name="b-original" select="$b-original" />
    </xsl:apply-templates>
    <xsl:text>\endgroup%&#xa;</xsl:text>
    <xsl:if test="following-sibling::solution">
        <xsl:call-template name="exercise-component-separator"/>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
