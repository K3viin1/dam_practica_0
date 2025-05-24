<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/cartelera">
        <html lang='es'>
            <head>
                <meta charset="UTF-8" />
                <title>Cartelera de Cine</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="style.css" />
            </head>
            <body>

                <header>
                    <h1>Cartelera de Cine</h1>
                    <h2>Cinemax Experience</h2>
                </header>

                <xsl:for-each select="recinto">
                  <div class="cine-container">
                    
                        <header>
                            <h3><xsl:value-of select="@value"/></h3>
                        </header>

                        <div class="peliculas-container">                            

                            <xsl:for-each select="evento">
                                <article class="pelicula-card">
                                    <div class="poster-container">
                                        <img src="{caratula}" alt="{titulo/@value}" class="poster" />
                                    </div>
                                    <div class="pelicula-info">
                                        <h3><xsl:value-of select="titulo/@value"/></h3>
                                        <div class="info-item">
                                            Classificación: <span><xsl:value-of select="classificacion"/></span>
                                        </div>

                                        <div class="extra-info">
                                          <div class="info-item"> 
                                            Genero: <span><xsl:value-of select="genero"/></span>
                                          </div>

                                          <div class="info-item">
                                            Duración: <span><xsl:value-of select="duracion"/></span>
                                          </div>

                                        </div>
                                        <p><xsl:value-of select="sinopsis"/></p>                                        
                                    </div>
                                    <div class="links">
                                       <xsl:choose>
                                            <xsl:when test="trailer != ''">
                                                <a class="trailer" href="{trailer}" target="_blank">Ver trailer</a>
                                            </xsl:when>
                                        </xsl:choose>
                                            <a class="compra" href="{compra}" target="_blank">Comprar ahora</a>
                                        </div>
                                </article>
                            </xsl:for-each>

                        </div>
                  </div>
                </xsl:for-each>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>