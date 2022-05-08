var lunr = require('lunr')
require('lunr-languages/lunr.stemmer.support')(lunr);
require('lunr-languages/lunr.zh')(lunr);

const fs = require('fs')
fs.readFile('index.json', 'utf8' , (err, data) => {
  if (err) {
    console.error(err)
    return
  }
  var idx = lunr.Index.load(JSON.parse(data))
  
  fs.readFile('content-map.json', 'utf8' , (err, data) => {
    if (err) {
      console.error(err)
      return
    }
    let contentMap = JSON.parse(data);
    var results = idx.search("redis")
    results.forEach((result) => console.log(contentMap[result.ref].title) )
  });

})  


