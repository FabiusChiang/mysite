const cheerio=require('cheerio');
const http = require('http');


// var fs = require('fs');
// var htmltext = fs.readFileSync("../../expressSite/static/wordpressSample.html");

async function extractContent(url){
    // url = 'http://blog.fabiuslela.com/fabiuss-introduction/';
    return new Promise((resolve, reject) => {
        http.get(url, (resp) => {
            let data = '';

            // A chunk of data has been recieved.
            resp.on('data', (chunk) => {
                data += chunk;
            });
            resp.on('end', () => {
                return resolve(getContentPerHtml(data));
            });

        });        
    });


}

function getContentPerHtml(htmlPage) {
    const $=cheerio.load(htmlPage);
    const targetHtml = $('article .entry-content');
    const contentString = $.html(targetHtml);
    return contentString;
}

// async function test(){
//     const result = await extractContent('http://blog.fabiuslela.com/fabiuss-introduction/');

//     console.log(result);
// }

// test();

export default extractContent;