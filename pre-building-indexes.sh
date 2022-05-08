var lunr = require('lunr'),
stdout = process.stdout
require("lunr-languages/lunr.stemmer.support")(lunr)
require("lunr-languages/lunr.zh")(lunr)
require('lunr-languages/lunr.multi')(lunr)

var HTMLParser = require('node-html-parser');


var fs = require('fs');
var path = require('path');//解析需要遍历的文件夹
const USER_HOME = process.env.HOME || process.env.USERPROFILE
var filePath = path.resolve(USER_HOME + '/public_html');

let documents = []

function fileDisplay(filePath){
    //根据文件路径读取文件，返回文件列表
    let files = fs.readdirSync(filePath); 
    //遍历读取到的文件列表
    var index = 1;
    files.forEach(function(filename) {
                      //获取当前文件的绝对路径
                      var filedir = path.join(filePath, filename);
                      //根据文件路径获取文件信息，返回一个fs.Stats对象
                      if (path.extname(filedir) != '.html') {
                             return
                         }
                         var data = fs.readFileSync(filedir);
                         var root = HTMLParser.parse(data);
                         if (root.querySelector('title')) {
                                var document = {}
                                document.id = index;
                                document.title = root.querySelector('title').text; 
                                document.body = root.querySelector('body').text; 
                                index++;
                                documents.push(document);
                            }
                  });
}




fileDisplay(filePath)
var idx = lunr(function () {
                   this.use(lunr.multiLanguage('en', 'zh'))
                   this.ref('id')
                   this.field('title')
                   this.field('body')
                   
                   documents.forEach(function (doc) {
                                         this.add(doc)
                                     }, this)
               })

stdout.write(JSON.stringify(idx))
