<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <html>
    <head>
      <title>Cartelera de Cines</title>
      <meta charset="UTF-8"/>
      <style>
        body {
          font-family: Arial, sans-serif;
          margin: 0;
          padding: 20px;
          background-color: #f0f0f0;
        }
        .container {
          max-width: 1200px;
          margin: 0 auto;
        }
        header {
          background-color: #2c3e50;
          color: white;
          padding: 20px;
          text-align: center;
          border-radius: 8px 8px 0 0;
          margin-bottom: 30px;
        }
        h1 {
          margin: 0;
          font-size: 28px;
        }
        .cinema-info {
          margin-bottom: 20px;
          background-color: #34495e;
          color: white;
          padding: 15px;
          border-radius: 8px;
        }
        .cinema-name {
          font-size: 24px;
          margin: 0 0 10px 0;
        }
        .cinema-address {
          margin: 0;
          font-size: 16px;
        }
        .movie-table {
          width: 100%;
          border-collapse: collapse;
          background-color: white;
          box-shadow: 0 2px 10px rgba(0,0,0,0.1);
          border-radius: 8px;
          overflow: hidden;
          margin-bottom: 30px;
        }
        .movie-table th {
          background-color: #3498db;
          color: white;
          padding: 12px 15px;
          text-align: left;
        }
        .movie-table td {
          padding: 12px 15px;
          border-bottom: 1px solid #ddd;
        }
        .movie-table tr:last-child td {
          border-bottom: none;
        }
        .movie-table tr:nth-child(even) {
          background-color: #f9f9f9;
        }
        .poster {
          width: 120px;
          height: auto;
          border-radius: 4px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .movie-title {
          font-weight: bold;
          font-size: 18px;
          color: #2c3e50;
        }
        .sinopsis {
          max-width: 500px;
          line-height: 1.4;
        }
        .links a {
          display: inline-block;
          margin-right: 10px;
          padding: 6px 12px;
          background-color: #e74c3c;
          color: white;
          text-decoration: none;
          border-radius: 4px;
          font-size: 14px;
          transition: background-color 0.3s;
        }
        .links a:hover {
          background-color: #c0392b;
        }
        .no-content {
          color: #999;
          font-style: italic;
        }
        footer {
          text-align: center;
          margin-top: 20px;
          padding: 15px;
          background-color: #2c3e50;
          color: white;
          border-radius: 0 0 8px 8px;
        }
      </style>
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