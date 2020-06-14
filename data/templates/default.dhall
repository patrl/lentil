λ(page : ../types/Page.dhall) →
  ''
  <!DOCTYPE html>
  <html>
      <head>
          <title>${(../config.dhall).title} - ${page.title}</title>
          <link rel="stylesheet" href="${page.style}">
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <meta name="author" content="${(../config.dhall).author}">
          <meta charset="utf-8">
      </head>
      <body id="top">
          <main>
              ${page.contents}

              <footer class="text-muted small">
                      powered by <a href="https://github.com/patrl/lentil">lentil</a>

                      Last modified: ${page.date}
              </footer>
          </main>
      </body>
  </html>
    ''
