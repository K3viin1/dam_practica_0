<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <html>
    <head>
      <title>Cartelera de Cines</title>
      <meta charset="UTF-8"/>
  
    </head>
    <body>
      <div class="container">
        <header>
          <h1>Cartelera de Cines</h1>
        </header>
        
        <xsl:apply-templates select="/cartelera/recinto"/>
        
        <footer>
          <p>Última actualización: <xsl:value-of select="cartelera/@last-mod"/></p>
        </footer>
      </div>
    </body>
  </html>
</xsl:template>


<xsl:template match="recinto">
  <div class="cinema-info">
    <h2 class="cinema-name"><xsl:value-of select="@value"/></h2>
    <p class="cinema-address">
      <xsl:value-of select="address"/>, 
      <xsl:value-of select="postcode"/>, 
      <xsl:value-of select="city"/>
    </p>
  </div>
  
  <table class="movie-table">
    <thead>
      <tr>
        <th>Carátula</th>
        <th>Información</th>
        <th>Sinopsis</th>
        <th>Enlaces</th>
      </tr>
    </thead>
    <tbody>
      <xsl:apply-templates select="evento"/>
    </tbody>
  </table>
</xsl:template>

<xsl:template match="evento">
  <tr>
    <td>
      <xsl:choose>
        <xsl:when test="caratula and caratula != ''">
          <img class="poster">
            <xsl:attribute name="src">
              <xsl:value-of select="caratula"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="titulo/@value"/>
            </xsl:attribute>
          </img>
        </xsl:when>
        <xsl:otherwise>
          <span class="no-content">Sin imagen</span>
        </xsl:otherwise>
      </xsl:choose>
    </td>
    <td>
      <div class="movie-title"><xsl:value-of select="titulo/@value"/></div>
      <p>
        <strong>Calificación: </strong>
        <xsl:choose>
          <xsl:when test="calificacion and calificacion != ''">
            <xsl:value-of select="calificacion"/>
          </xsl:when>
          <xsl:otherwise>
            <span class="no-content">No disponible</span>
          </xsl:otherwise>
        </xsl:choose>
      </p>
      <p>
        <strong>Género: </strong>
        <xsl:choose>
          <xsl:when test="genero and genero != ''">
            <xsl:value-of select="genero"/>
          </xsl:when>
          <xsl:otherwise>
            <span class="no-content">No disponible</span>
          </xsl:otherwise>
        </xsl:choose>
      </p>
      <p>
        <strong>Duración: </strong>
        <xsl:choose>
          <xsl:when test="duracion and duracion != ''">
            <xsl:value-of select="duracion"/> minutos
          </xsl:when>
          <xsl:otherwise>
            <span class="no-content">No disponible</span>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </td>
    <td>
      <div class="sinopsis">
        <xsl:choose>
          <xsl:when test="sinopsis and sinopsis != ''">
            <xsl:value-of select="sinopsis"/>
          </xsl:when>
          <xsl:otherwise>
            <span class="no-content">Sinopsis no disponible</span>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </td>
    <td class="links">
      <a href="{compra}" target="_blank">Comprar entradas</a>
      
      <xsl:if test="trailer and trailer != ''">
        <a href="{trailer}" target="_blank">Ver trailer</a>
      </xsl:if>
    </td>
  </tr>
</xsl:template>

</xsl:stylesheet>