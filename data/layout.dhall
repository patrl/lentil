
  λ(pageInfo : { pageTitle : Text, contents : Text, style : Text })
→ ''
  <!DOCTYPE html>
  <html>
      <head>
          <title>Page Title</title>
          <link rel="stylesheet" href="${pageInfo.style}">
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      </head>
      <body id="top">
          <main>
              <h1>${pageInfo.pageTitle}</h1>

              ${pageInfo.contents}

              <footer>
                  <p>CSS available under the MIT license.</p>
              </footer>
          </main>
      </body>
  </html>
    ''
