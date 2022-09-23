const express = require('express')
const { createReadStream } = require('fs');
const app = express()
const port = 3000

const api_key = '12345';

app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.get('/download', (req, res) => {
    const { filename } = req.query;
    res.setHeader('Content-Type', mime.lookup(filename));
    res.writeHead(200);
    const fs = createReadStream(filename);
    fs.pipe(response)
    fs.on('finish', response.end);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
