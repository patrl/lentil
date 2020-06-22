λ(page : ../types/Page.dhall) →
  ''
  <!DOCTYPE html>
  <html>
      <head>
          <title>${(../config.dhall).title} - ${page.pageTitle}</title>
          <link rel="stylesheet" href="${page.pageStyle}">
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <meta name="author" content="${(../config.dhall).author}">
          <meta charset="utf-8">
      </head>
      <body id="top">
          <main>
          <nav>
            <a href="/">Home</a> | <a href="/drafts">Drafts</a> | <a href="/talks">Talks</a>
            </nav>
              ${page.pageContents}

              <hr>
              <footer class="text-muted small">
                      <p>powered by <a href="https://github.com/patrl/lentil">lentil</a></p>
                      <p>Last modified: ${page.pageDate}</p>
              </footer>
          </main>
      </body>
  </html>
    ''
