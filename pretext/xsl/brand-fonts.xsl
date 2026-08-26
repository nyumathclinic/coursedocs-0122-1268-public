<?xml version='1.0'?>

<!-- NYU brand typography (Contemporary/Subtle) for PDF/LaTeX output,      -->
<!-- shared by every PDF-producing target in this project (either directly -->
<!-- via target/@xsl, or transitively through worksheet-latex.xsl, which   -->
<!-- imports this file instead of core). Main text font (NYU Perstare) is  -->
<!-- set via the publication files' <latex><fonts><main .../></fonts>     -->
<!-- mechanism, not here: see publication/*.ptx.                          -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="./core/pretext-latex.xsl"/>

<!-- Division/section/worksheet headings: \divisionfont is core's hook,   -->
<!-- hard-wired into every division title project-wide. Give it a lighter -->
<!-- Perstare weight than the Regular body text, per the brand page's     -->
<!-- "use lighter weights of NYU Perstare" guidance for Contemporary/     -->
<!-- Subtle: headings should read thinner than body text, not heavier.    -->
<!-- The base template is empty (just commented-out examples), so this is -->
<!-- a safe full override: nothing to preserve via apply-imports.         -->
<!--                                                                      -->
<!-- Core's titlesec styles unconditionally apply \bfseries on top of     -->
<!-- \divisionfont for every heading level (e.g.                         -->
<!-- "{\divisionfont\Large\bfseries}" for \section, and worksheet titles  -->
<!-- route through the same \section styling). "NYU Perstare Light" has   -->
<!-- no true bold shape of its own, so without the BoldFont override      -->
<!-- below, that \bfseries synthesizes a *fake* bold: fontspec            -->
<!-- algorithmically thickens the strokes, which reads as heavier than    -->
<!-- intended, not lighter. Pointing BoldFont at the same Light file      -->
<!-- makes \bfseries within \divisionfont a no-op, so headings stay       -->
<!-- genuinely Light regardless of which titlesec style requests bold.    -->
<xsl:template name="font-xelatex-style">
    <xsl:text>\newfontfamily\divisionfontfamily{NYU Perstare Light}[BoldFont={NYU Perstare Light}]&#xa;</xsl:text>
    <xsl:text>\renewcommand{\divisionfont}{\divisionfontfamily}&#xa;</xsl:text>
</xsl:template>

<!-- Math font: Lete Sans Math. Not using core's generic publisher-driven -->
<!-- math-font mechanism (latex/fonts/math in the publication file) since -->
<!-- Lete Sans Math ships its own LaTeX package (feature options, AMS/    -->
<!-- latexsym symbol shims, extra math characters) that a bare            -->
<!-- \setmathfont{LeteSansMath.otf} call would not provide. The base      -->
<!-- template only fires when a publisher sets latex/fonts/math (which    -->
<!-- this project doesn't), so it's a safe full override here too.        -->
<xsl:template name="font-xelatex-math">
    <xsl:text>\usepackage{lete-sans-math}&#xa;</xsl:text>
</xsl:template>

</xsl:stylesheet>
