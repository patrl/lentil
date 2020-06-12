λ(pageInfo : { pageTitle : Text, contents : Text, style : Text, date : Text }) →
  ''
  <!DOCTYPE html>
  <html>
      <head>
          <title>${(../config.dhall).siteTitle} - ${pageInfo.pageTitle}</title>
          <link rel="stylesheet" href="${pageInfo.style}">
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <meta name="author" content="${(../config.dhall).siteAuthor}">
          <meta charset="utf-8">
      </head>
      <body id="top">
          <main>
              ${pageInfo.contents}

              <footer class="text-muted small">
                      powered by <a href="https://github.com/patrl/lentil">lentil</a>

                      Last modified: ${pageInfo.date}
              </footer>
          </main>
      </body>
  </html>
    ''
