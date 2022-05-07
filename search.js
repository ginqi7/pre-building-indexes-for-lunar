var lunr = require('lunr')
require('lunr-languages/lunr.stemmer.support')(lunr);
require('lunr-languages/lunr.zh')(lunr);

const fs = require('fs')
fs.readFile('/Users/a77/Downloads/pre-building-indexes-for-html-files/index.json', 'utf8' , (err, data) => {
  if (err) {
    console.error(err)
    return
  }
  var idx = lunr.Index.load(JSON.parse(data))

  console.log(idx)
  console.log(idx.search("redis"))  
})  


