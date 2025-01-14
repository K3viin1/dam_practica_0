# Práctica 0: Indicar URL GitHub personal y URL del repositorio publicado en GitHub (dentro se incluye el código del archivo push.yml para su GitHub)

Código para el archivo  .github/workflows/push.yml
 
 
nombre: Build and Deploy
donde: [push]
permisiones:
  contentos: write
jobs:
  build-and-deploy:
    concurrency: ci-${{github.ref}}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        usos: actions/checkout@v3

      - name: Deploy
        usos: JamesIves/github-pages-deploy-action@v4
        with:
          branch: gh-pages
          folder: .
          config: baseUrl=/
